
#define ATR_LABEL "StatLabel_ATR_LABEL"
#define ATR_VALUE "StatLabel_ATR_VALUE"
#define SL_LABEL "StatLabel_SL_LABEL"
#define SL_VALUE "StatLabel_SL_VALUE"
#define SPREAD_LABEL "StatLabel_SPREAD_LABEL"
#define SPREAD_VALUE "StatLabel_SPREAD_VALUE"
#define PAIR_VALUE "StatLabel_PAIR_VALUE"
#define LOT_LABEL "StatLabel_LOT_LABEL"
#define LOT_VALUE "StatLabel_LOT_VALUE"


class StatLabel {

public:
    string text;
    string name;
    bool summoned;
    int x_offset;
    int width;
    int subwindow;
    int font_size;
    int text_color;

    StatLabel(
        string name_arg,
        string text_arg,
        int subwindow_arg,
        int x_offset_arg,
        int width_arg,
        int font_size_arg,
        int text_color_arg
    ) {
        name = name_arg;
        text = text_arg;
        subwindow = subwindow_arg;
        x_offset = x_offset_arg;
        width = width_arg;
        font_size = font_size_arg;
        text_color = text_color_arg;
        summoned = false;
    }

    void summon() {
        ObjectCreate(0, name, OBJ_LABEL, subwindow, 0, 0);
        ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
        ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x_offset);
        ObjectSetInteger(0, name, OBJPROP_YDISTANCE, 0);
        ObjectSetString(0, name, OBJPROP_TEXT, text);
        ObjectSetInteger(0, name, OBJPROP_FONTSIZE, font_size);
        ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
        ObjectSetInteger(0, name, OBJPROP_YSIZE, 36);
        ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
        summoned = true;
    }

    void banish() {
        ObjectDelete(0, name);
    }

    void set_text(string text_arg) {
        text = text_arg;
        ObjectSetString(0, name, OBJPROP_TEXT, text);
    }
};

