
double get_atr() {
    return iATR(Symbol(), Period(), 14, 0);
}
int to_pips(double price) {
    return (int)MathRound(MathPow(10, Digits - 1) * price);
}

// Get lot size for given percentage of account balance with given stop loss multiplier
long get_lot_size(double percentage, double stop_mult) {
    double risk = get_percent(percentage);
    double stop_pips = to_double_pips(get_stop_loss(stop_mult));
    double ppp = get_ppp();
    return (long)MathRound(risk / (ppp * stop_pips));
}

// Get percentage of account balance rounded to nearest currency unit.
double get_percent(double percentage) {
    double ratio = percentage / 100.0;
    long rounded = (long)MathRound(AccountBalance() * ratio);
    return (double)rounded;
}

double get_stop_loss(double stop_mult) {
    return stop_mult * get_atr();
}

double to_double_pips(double price) {
    return (double)to_fp(price) / 10;
}

// ppp: Profit Per Pip
//       The profit in account currency for each pip for a single lot unit.
double get_ppp() {
    double home_price = MarketInfo(Symbol(), MODE_TICKVALUE);
    return home_price * 0.0001;
}

int to_fp(double price) {
    return (int)MathRound(MathPow(10, Digits) * price);
}
