import 'package:flutter/material.dart';

class Scale {

    Size _size;
    double _dpr;

    Scale(BuildContext context) {
        _size = MediaQuery.of(context).size;
        _dpr = MediaQuery.of(context).devicePixelRatio;
    }

    double get actualWidth {
        return _size.width * _dpr;
    }

    double get actualHeight {
        return _size.height * _dpr;
    }

    double get width {
        return _size.width;
    }

    double get height {
        return _size.height;
    }

    double get actualLongestSide {
        return _size.longestSide * _dpr;
    }

    double get actualShortestSide {
        return _size.shortestSide * _dpr;
    }

    double get longestSide {
        return _size.longestSide;
    }

    double get shortestSide {
        return _size.shortestSide;
    }

}