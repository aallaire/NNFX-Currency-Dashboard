#property strict
#property indicator_separate_window
#property indicator_height 36

#include "stat_text\\stat_grid.mqh"
#include "currency\\currency_grid.mqh"

input double Stop_Multiplier = 1.5;
input double Risk_Percentage = 1.0;

StatGrid *stat_grid;
CurrencyGrid *currency_grid;

int OnInit() {
    stat_grid = new StatGrid(ChartWindowFind(), Stop_Multiplier, Risk_Percentage);
    currency_grid = new CurrencyGrid(ChartWindowFind());
    stat_grid.summon();
    currency_grid.summon();

   return(INIT_SUCCEEDED);
}

void OnDeinit(const int reason) {
    delete currency_grid;
    delete stat_grid;
}

void OnChartEvent(const int id, const long &lparam, const double &dparam, const string &sparam) {
    currency_grid.on_event(sparam);
}

int OnCalculate(
    const int rates_total, const int prev_calculated, const datetime &time[],
    const double &open[], const double &high[], const double &low[], const double &close[],
    const long &tick_volume[], const long &volume[], const int &spread[]
) {
    stat_grid.update();
    return(rates_total);
}
