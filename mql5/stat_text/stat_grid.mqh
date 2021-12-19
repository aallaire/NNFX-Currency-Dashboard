
#include "..\\basic\\util.mqh"
#include "stat_label.mqh"
#include "..\\basic\\indicator.mqh"

class StatGrid {
private:
    int subwindow;
    double stop_mult;
    double risk_percent;
public:
    StatLabel *pair_value;
    StatLabel *atr_label;
    StatLabel *atr_value;
    StatLabel *sl_label;
    StatLabel *sl_value;
    StatLabel *lot_label;
    StatLabel *lot_value;
    StatLabel *spread_label;
    StatLabel *spread_value;
    Indicator *atr_indicator;
    IndicatorGrabber *atr_grabber;
    bool summoned;

    StatGrid(int subwindow_arg, double stop_mult_arg, double risk_percent_arg, Indicator *atr_indicator_arg) {
        subwindow = subwindow_arg;
        stop_mult = stop_mult_arg;
        risk_percent = risk_percent_arg;
        atr_indicator = atr_indicator_arg;

        atr_label = new StatLabel(ATR_LABEL, "ATR:", subwindow, 90, 30, 10, clrDodgerBlue);
        atr_value = new StatLabel(ATR_VALUE, "", subwindow, 122, 50, 16, clrWhite);
        sl_label = new StatLabel(SL_LABEL, "SL:", subwindow, 190, 30, 10, clrDodgerBlue);
        sl_value = new StatLabel(SL_VALUE, "", subwindow, 212, 50, 16, clrWhite);
        lot_label = new StatLabel(LOT_LABEL, "Lot:", subwindow, 282, 50, 10, clrDodgerBlue);
        lot_value = new StatLabel(LOT_VALUE, "", subwindow, 305, 70, 14, clrWhite);

        pair_value = new StatLabel(PAIR_VALUE, "", subwindow, 420, 100, 20, clrYellow);

        spread_label = new StatLabel(SPREAD_LABEL, "spread:", subwindow, 570, 50, 10, clrDodgerBlue);
        spread_value = new StatLabel(SPREAD_VALUE, "", subwindow, 614, 50, 16, clrWhite);

        atr_grabber = new IndicatorGrabber(atr_indicator, 0, 10);

        update();

        summoned = false;
    }

    ~StatGrid() {
        banish();
        delete atr_label;
        delete atr_value;
        delete sl_label;
        delete sl_value;
        delete spread_label;
        delete spread_value;
        delete lot_label;
        delete lot_value;
        delete pair_value;
        delete atr_grabber;
    }

    void summon() {
        pair_value.summon();
        atr_label.summon();
        atr_value.summon();
        sl_label.summon();
        sl_value.summon();
        spread_label.summon();
        spread_value.summon();
        lot_label.summon();
        lot_value.summon();
        summoned = true;
    }

    void banish() {
        pair_value.banish();
        atr_label.banish();
        atr_value.banish();
        sl_label.banish();
        sl_value.banish();
        spread_label.banish();
        spread_value.banish();
        lot_label.banish();
        lot_value.banish();
        summoned = false;
    }

    void update() {
        double raw_atr = atr_grabber.grab(0);
        int atr = to_pips(raw_atr);
        int stop_loss = to_pips(stop_mult * raw_atr);
        string atr_string = IntegerToString(atr);
        string stop_string = IntegerToString(stop_loss);
        atr_value.set_text(atr_string);
        sl_value.set_text(stop_string);
        long spread = SymbolInfoInteger(Symbol(), SYMBOL_SPREAD);
        string spread_string = DoubleToString((double)spread / 10.0, 1);
        spread_value.set_text(spread_string);
        pair_value.set_text(Symbol());
        long size = get_lot_size(risk_percent, stop_mult);
        lot_value.set_text(IntegerToString(size));
    }

};