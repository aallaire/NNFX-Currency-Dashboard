#include "currency.mqh"

class CurrencyButton {
private:
    static int grid_x_distance;
    static int grid_y_distance;
    static int grid_x_offset;
    static int grid_y_offset;
    static string prefix;
    static int prefix_length;

    int x_distance;
    int y_distance;
    int subwindow;

public:
    string currency;
    string name;
    CurrencyIndexEnum index;
    bool summoned;

    CurrencyButton(string currency_arg, int subwindow_arg) {
        subwindow = subwindow_arg;
        currency = currency_arg;
        index = get_currency_index(currency);
        x_distance = grid_x_distance + (grid_x_offset * index);
        y_distance = grid_y_distance + (grid_y_offset * index);
        summoned = false;
        name = prefix + currency;
    }

    void summon() {
        ObjectCreate(0, name, OBJ_BUTTON, subwindow, 0, 0);
        ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_RIGHT_UPPER);
        ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x_distance);
        ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y_distance);
        ObjectSetString(0, name, OBJPROP_TEXT, currency);
        ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 14);
        ObjectSetInteger(0, name, OBJPROP_XSIZE, 50);
        ObjectSetInteger(0, name, OBJPROP_YSIZE, 30);
        set_defaults();
        summoned = true;
    }

    void banish() {
        ObjectDelete(0, name);
        summoned = false;
    }

    void set_pressed() {
        ObjectSetInteger(0, name, OBJPROP_STATE, true);
    }

    void set_released() {
        ObjectSetInteger(0, name, OBJPROP_STATE, false);
    }

    void set_anchor_border() {
        if (summoned) {
            ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, clrYellow);
        }
    }

    void set_other_border() {
        if (summoned) {
            ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, clrDodgerBlue);
        }
    }

    void set_base_color() {
        if (summoned) {
            ObjectSetInteger(0, name, OBJPROP_COLOR, clrWhite);
            ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrForestGreen);
            ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 14);
        }
    }

    void set_quote_color() {
        if (summoned) {
            ObjectSetInteger(0, name, OBJPROP_COLOR, clrWhite);
            ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrOrangeRed);
            ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 14);
        }
    }

    void set_defaults() {
        if (summoned) {
            ObjectSetInteger(0, name, OBJPROP_COLOR, clrDarkGray);
            ObjectSetInteger(0, name, OBJPROP_BGCOLOR, clrBlack);
            ObjectSetInteger(0, name, OBJPROP_FONTSIZE, 8);
            ObjectSetInteger(0, name, OBJPROP_BORDER_COLOR, clrNONE);
        }
    }

    static CurrencyIndexEnum obj_name_to_index(string name_value) {
        string currency_string = "";
        string prefix_value = StringSubstr(name_value, 0, prefix_length);
        if (prefix_value == prefix) {
            currency_string = StringSubstr(name_value, prefix_length);
        }
        return get_currency_index(currency_string);
    }

};

int CurrencyButton::grid_x_distance = 432;
int CurrencyButton::grid_y_distance = 0;
int CurrencyButton::grid_x_offset = -54;
int CurrencyButton::grid_y_offset = 0;
string CurrencyButton::prefix = "CurrencyButton_";
int CurrencyButton::prefix_length = StringLen(CurrencyButton::prefix);
