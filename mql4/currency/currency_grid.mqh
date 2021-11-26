#include "currency_button.mqh"

class CurrencyGrid {
private:
    CurrencyButton *buttons[8];
    CurrencyIndexEnum anchor_selected;
    CurrencyIndexEnum other_selected;
    string pair;
    string base;
    string quote;
    int subwindow;
    static string anchor_global_name;
    static string other_global_name;

public:
    CurrencyGrid(int subwindow_arg) {
        subwindow = subwindow_arg;
        for (int i = 0; i < 8; i++) {
            buttons[i] = new CurrencyButton(get_currency_name(i), subwindow);
        }
        pair = get_currency_pair();
        base = get_base_currency(pair);
        quote = get_quote_currency(pair);
        anchor_selected = get_currency_index(base);
        other_selected = get_currency_index(quote);
        // If global has same pair but different one anchored, switch them.
        CurrencyIndexEnum global_anchor = get_global_anchor();
        CurrencyIndexEnum global_other = get_global_other();
        if (global_anchor == other_selected && global_other == anchor_selected) {
            anchor_selected = global_anchor;
            other_selected = global_other;
        }
        summon();
        update();
    }

    ~CurrencyGrid() {
        banish();
        for (int i = 0; i < 8; ++i) {
            delete buttons[i];
        }
    }

    void summon() {
        for (int i = 0; i < 8; ++i) {
            if (! buttons[i].summoned) buttons[i].summon();
        }
    }

    void banish() {
        for (int i = 0; i < 8; ++i) {
            if (buttons[i].summoned) buttons[i].banish();
        }
    }

    CurrencyIndexEnum get_global_anchor() {
        if (GlobalVariableCheck(anchor_global_name)) {
            double global_value = GlobalVariableGet(anchor_global_name);
            return (CurrencyIndexEnum)global_value;
        }
        return CURRENCY_INDEX_INVALID;
    }

    CurrencyIndexEnum get_global_other() {
        if (GlobalVariableCheck(other_global_name)) {
            double global_value = GlobalVariableGet(other_global_name);
            return (CurrencyIndexEnum)global_value;
        }
        return CURRENCY_INDEX_INVALID;
    }

    void on_event(string string_param) {
        // To be called when there is an object event, that might involve our buttons.
        CurrencyIndexEnum index = CurrencyButton::obj_name_to_index(string_param);
        if (index != CURRENCY_INDEX_INVALID) {
            if (index == other_selected) {
                CurrencyIndexEnum old_anchor_selected = anchor_selected;
                anchor_selected = other_selected;
                other_selected = old_anchor_selected;
            } else if (index != anchor_selected) {
                other_selected = index;
            }
            update();
        }
    }

    // Update all else based on anchor_selected and other_selected
    void update() {
        string old_pair = pair;
        pair = get_currency_pair(anchor_selected, other_selected);
        base = get_base_currency(pair);
        quote = get_quote_currency(pair);
        int base_index = get_currency_index(base);
        int quote_index = get_currency_index(quote);
        for (int i = 0; i < 8; i++) {
            buttons[i].set_released();
            if (i == base_index) {
                buttons[i].set_base_color();
            } else if (i == quote_index) {
                buttons[i].set_quote_color();
            } else {
                buttons[i].set_defaults();
            }
            if (i == anchor_selected) {
                buttons[i].set_anchor_border();
            } else if (i == other_selected) {
                buttons[i].set_other_border();
            }
        }
        if (old_pair != pair) {
            GlobalVariableSet(anchor_global_name, anchor_selected);
            GlobalVariableSet(other_global_name, other_selected);
            ChartSetSymbolPeriod(0, pair, 0);
        }
    }

};

string CurrencyGrid::anchor_global_name = "currency_grid_anchor_3603b94efa57";
string CurrencyGrid::other_global_name = "currency_grid_other_3603b94efa57";

