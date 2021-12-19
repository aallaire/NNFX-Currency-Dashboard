#ifndef INDICATOR_H
#define INDICATOR_H

class Indicator {
public:
    int handle;
    bool valid;

     Indicator(int handle_arg) {
         handle = handle_arg;
         valid = (handle != INVALID_HANDLE);
     }

     int copy_buffer(int buffer_index, int i, int count, double &buffer[]) {
         return CopyBuffer(handle, buffer_index, i, count, buffer);
     }
};


class IndicatorGrabber {
private:
    Indicator *_indicator;
    int _buffer_index, _buffer_size, _current_index, _num_loaded;
    bool _marching, _reversed;
    double _buffer[];
public:
    double march_value;
    int march_step;

    IndicatorGrabber(Indicator *indicator, int buffer_index, int buffer_size) {
       _indicator = indicator;
       _buffer_index = buffer_index;
       _buffer_size = buffer_size;
       _current_index = -1;
       _marching = false;
       _reversed = false;
       _num_loaded = -1;
       march_value = 0.0;
       march_step = -1;
       ArrayResize(_buffer, _buffer_size, 0);
    }

    int copy_buffer(int i, int count, double &buffer[]) {
        return _indicator.copy_buffer(_buffer_index, i, count, buffer);
    }

    int copy_buffer(int count, double &buffer[]) {
        return _indicator.copy_buffer(_buffer_index, _current_index, count, buffer);
    }

    int copy_buffer(double &buffer[]) {
        return _indicator.copy_buffer(_buffer_index, _current_index, _buffer_size, buffer);
    }

    double grab(int i) {
        cancel_march();
        _current_index = i;
        _num_loaded = 0;
        ArrayResize(_buffer, _buffer_size, 0);
        _num_loaded = copy_buffer(i, _buffer_size, _buffer);
        if (_num_loaded < 1) return 0.0;
        return _buffer[_num_loaded - 1];
    }

    int size() {
        return _num_loaded;
    }

    double from_end(int shift) {
        if (shift + 1 > _num_loaded || shift < 0) return 0.0;
        return _buffer[_num_loaded - 1 - shift];
    }

    double from_front(int shift) {
        if (shift + 1 > _num_loaded || shift < 0) return 0.0;
        return _buffer[shift];
    }

    void start_march(int i, bool reverse) {
        grab(i);
        _marching = true;
        _reversed = reverse;
        march_step = -1;
        march_value = 0.0;
    }

    void cancel_march() {
        _marching = false;
        _reversed = false;
        march_step = -1;
        march_value = 0.0;
    }

    bool step() {
        if (! _marching || march_step + 2 > _num_loaded || march_step < -1) {
            cancel_march();
            return false;
        }
        if (_reversed) {
            march_value = from_end(++march_step);
        } else {
            march_value = from_front(++march_step);
        }
        return true;
    }
};


class MedianTaker {
private:
    Indicator *_indicator;
    int _buffer_index, _buffer_size;
    double _buffer[];

public:
    MedianTaker(Indicator *indicator, int buffer_index, int buffer_size) {
        _indicator = indicator;
        _buffer_index = buffer_index;
        _buffer_size = buffer_size;
        ArrayResize(_buffer, _buffer_size, 0);
    }

    double find(int i) {
        ArrayFill(_buffer, 0, _buffer_size, 0.0);
        int num_loaded = _indicator.copy_buffer(_buffer_index, i, _buffer_size, _buffer);
        int half_ndx = (int)MathRound((double)(_buffer_size - 1) / 2.0);
        ArraySort(_buffer);
        return _buffer[half_ndx];
    }
};


#endif // INDICATOR_H