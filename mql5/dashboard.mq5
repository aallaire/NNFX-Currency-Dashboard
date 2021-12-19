#property strict
#property indicator_separate_window
#property indicator_height 36

#property indicator_buffers 1
#property indicator_plots 1


#include "basic\\indicator.mqh"
#include "stat_text\\stat_grid.mqh"
#include "currency\\currency_grid.mqh"

#define ATR_BUFFER_INDEX 0

input double Stop_Multiplier = 1.5;  // Stop Multiplier
input double Risk_Percentage = 1.0;  // Risk Percentage
input int ATR_Period = 14;  // ATR Period

StatGrid *stat_grid;
CurrencyGrid *currency_grid;

double atr_buffer[];

Indicator *i_atr;


int OnInit() {
    SetIndexBuffer(ATR_BUFFER_INDEX, atr_buffer);

    IndicatorSetString(INDICATOR_SHORTNAME, "Dashboard");
    i_atr = new Indicator(iATR(Symbol(), Period(), ATR_Period));

    stat_grid = new StatGrid(ChartWindowFind(), Stop_Multiplier, Risk_Percentage, i_atr);
    currency_grid = new CurrencyGrid(ChartWindowFind());
    stat_grid.summon();
    currency_grid.summon();

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
    delete i_atr;
    delete currency_grid;
    delete stat_grid;
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam) {
    currency_grid.on_event(id, sparam);
}

int OnCalculate(
    const int rates_total, const int prev_calculated, const datetime &time[],
    const double &open[], const double &high[], const double &low[], const double &close[],
    const long &tick_volume[], const long &volume[], const int &spread[]
) {
    stat_grid.update();
    return(rates_total);
}
