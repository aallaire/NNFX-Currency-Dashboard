# NNFX-Currency-Dashboard (Version 0.0.1)
MT4 Indicator, Using 8 currency buttons to change to 28 currency pairs. Also displays some current stats commonly used in NNFX framework such as ATR, Stop Loss, and 1% Risk Lot Size. 

![Alt text](images/dashboard.PNG)


### Release History

1. Version 0.0.2
    1. The mql5 directory was added with the mql5 version of this indicator.
    1. None of the issues from 0.0.1 (see below) were addressed yet.
    1. At present presumes following about broker (both mql4 and mql5):
        1. For Lot Size, Broker allows lot sizes in units of currency (like Oanda does).
        1. The smallest price point is a fractional pip rather than a pip (this is common I think).

1. Version 0.0.1
    1. This is the initial release and there are some known issues already.
        1. Issue: Does NOT work well when open in more than one Chart. This should be fixed in later version. Until then please only use on one chart at a time.
        1. Issue: Color scheme is hard coded to work with black background. If your charts use white background, the white text will be a bit like disappearing ink.
        1. Issue: Only 8 major currencies are supported. Plus the design does not make it easy to add more.

