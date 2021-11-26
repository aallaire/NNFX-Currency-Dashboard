
#define EUR "EUR"
#define GBP "GBP"
#define AUD "AUD"
#define NZD "NZD"
#define USD "USD"
#define CAD "CAD"
#define CHF "CHF"
#define JPY "JPY"

#define EURGBP "EURGBP"
#define EURAUD "EURAUD"
#define EURNZD "EURNZD"
#define EURUSD "EURUSD"
#define EURCAD "EURCAD"
#define EURCHF "EURCHF"
#define EURJPY "EURJPY"
#define GBPAUD "GBPAUD"
#define GBPNZD "GBPNZD"
#define GBPUSD "GBPUSD"
#define GBPCAD "GBPCAD"
#define GBPCHF "GBPCHF"
#define GBPJPY "GBPJPY"
#define AUDNZD "AUDNZD"
#define AUDUSD "AUDUSD"
#define AUDCAD "AUDCAD"
#define AUDCHF "AUDCHF"
#define AUDJPY "AUDJPY"
#define NZDUSD "NZDUSD"
#define NZDCAD "NZDCAD"
#define NZDCHF "NZDCHF"
#define NZDJPY "NZDJPY"
#define USDCAD "USDCAD"
#define USDCHF "USDCHF"
#define USDJPY "USDJPY"
#define CADCHF "CADCHF"
#define CADJPY "CADJPY"
#define CHFJPY "CHFJPY"

enum CurrencyIndexEnum {
    CURRENCY_INDEX_INVALID = -1,
    EUR_INDEX = 0, GBP_INDEX = 1, AUD_INDEX = 2, NZD_INDEX = 3,
    USD_INDEX = 4, CAD_INDEX = 5, CHF_INDEX = 6, JPY_INDEX = 7
} ;

CurrencyIndexEnum get_currency_index(const string currency) {
    if (currency == EUR) return EUR_INDEX;
    if (currency == GBP) return GBP_INDEX;
    if (currency == AUD) return AUD_INDEX;
    if (currency == NZD) return NZD_INDEX;
    if (currency == USD) return USD_INDEX;
    if (currency == CAD) return CAD_INDEX;
    if (currency == CHF) return CHF_INDEX;
    if (currency == JPY) return JPY_INDEX;
    return CURRENCY_INDEX_INVALID;
}

string get_currency_name(CurrencyIndexEnum index) {
    switch (index) {
        case EUR_INDEX: return EUR;
        case GBP_INDEX: return GBP;
        case AUD_INDEX: return AUD;
        case NZD_INDEX: return NZD;
        case USD_INDEX: return USD;
        case CAD_INDEX: return CAD;
        case CHF_INDEX: return CHF;
        case JPY_INDEX: return JPY;
    }
    return "";
}

string get_currency_name(int index) {
    return get_currency_name((CurrencyIndexEnum)index);
}

string get_base_currency(string pair) {
    return (StringLen(pair) == 6) ? StringSubstr(pair, 0, 3) : "";
}

string get_base_currency() {
    return get_base_currency(Symbol());
}

string get_quote_currency(string pair) {
    return (StringLen(pair) == 6) ? StringSubstr(pair, 3, 3) : "";
}

string get_quote_currency() {
    return get_quote_currency(Symbol());
}

string get_currency_pair() {
    return Symbol();
}

string get_currency_pair(CurrencyIndexEnum index_1, CurrencyIndexEnum index_2) {
    switch (index_1) {
        case EUR_INDEX:
            switch(index_2) {
                /*       EUR vs EUR         */   case GBP_INDEX: return EURGBP;
                case AUD_INDEX: return EURAUD;   case NZD_INDEX: return EURNZD;
                case USD_INDEX: return EURUSD;   case CAD_INDEX: return EURCAD;
                case CHF_INDEX: return EURCHF;   case JPY_INDEX: return EURJPY;
            }
        break;
        case GBP_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURGBP;   /*       GBP vs GBP         */
                case AUD_INDEX: return GBPAUD;   case NZD_INDEX: return GBPNZD;
                case USD_INDEX: return GBPUSD;   case CAD_INDEX: return GBPCAD;
                case CHF_INDEX: return GBPCHF;   case JPY_INDEX: return GBPJPY;
            }
        break;
        case AUD_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURAUD;   case GBP_INDEX: return GBPAUD;
                /*        AUD vs AUD        */   case NZD_INDEX: return AUDNZD;
                case USD_INDEX: return AUDUSD;   case CAD_INDEX: return AUDCAD;
                case CHF_INDEX: return AUDCHF;   case JPY_INDEX: return AUDJPY;
            }
        break;
        case NZD_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURNZD;   case GBP_INDEX: return GBPNZD;
                case AUD_INDEX: return AUDNZD;   /*        NZD vs NZD        */
                case USD_INDEX: return NZDUSD;   case CAD_INDEX: return NZDCAD;
                case CHF_INDEX: return NZDCHF;   case JPY_INDEX: return NZDJPY;
            }
        break;
        case USD_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURUSD;   case GBP_INDEX: return GBPUSD;
                case AUD_INDEX: return AUDUSD;   case NZD_INDEX: return NZDUSD;
                /*        USD vs USD        */   case CAD_INDEX: return USDCAD;
                case CHF_INDEX: return USDCHF;   case JPY_INDEX: return USDJPY;
            }
        break;
        case CAD_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURCAD;   case GBP_INDEX: return GBPCAD;
                case AUD_INDEX: return AUDCAD;   case NZD_INDEX: return NZDCAD;
                case USD_INDEX: return USDCAD;   /*        CAD vs CAD        */
                case CHF_INDEX: return CADCHF;   case JPY_INDEX: return CADJPY;
            }
        break;
        case CHF_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURCHF;   case GBP_INDEX: return GBPCHF;
                case AUD_INDEX: return AUDCHF;   case NZD_INDEX: return NZDCHF;
                case USD_INDEX: return USDCHF;   case CAD_INDEX: return CADCHF;
                /*        CHF vs CHF        */   case JPY_INDEX: return CHFJPY;
            }
        break;
        case JPY_INDEX:
            switch(index_2) {
                case EUR_INDEX: return EURJPY;   case GBP_INDEX: return GBPJPY;
                case AUD_INDEX: return AUDJPY;   case NZD_INDEX: return NZDJPY;
                case USD_INDEX: return USDJPY;   case CAD_INDEX: return CADJPY;
                case CHF_INDEX: return CHFJPY;   /*        JPY vs JPY        */
            }
        break;
    }
    return "";
}

string get_currency_pair(string currency_1, string currency_2) {
    CurrencyIndexEnum index_1 = get_currency_index(currency_1);
    CurrencyIndexEnum index_2 = get_currency_index(currency_2);
    return get_currency_pair(index_1, index_2);
}
