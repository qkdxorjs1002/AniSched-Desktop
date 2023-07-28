import 'package:flutter/material.dart';

class Scale {

    Size? _size;
    late double _dpr;
    final double targetSize;

    Scale(BuildContext context, { this.targetSize = 1440 }) {
        _size = MediaQuery.of(context).size;
        _dpr = MediaQuery.of(context).devicePixelRatio;
    }

    Size? get size => _size;

    double get actualWidth {
        return _size!.width * _dpr;
    }

    double get actualHeight {
        return _size!.height * _dpr;
    }

    double get width {
        return _size!.width;
    }

    double get height {
        return _size!.height;
    }

    double get actualLongestSide {
        return _size!.longestSide * _dpr;
    }

    double get actualShortestSide {
        return _size!.shortestSide * _dpr;
    }

    double get longestSide {
        return _size!.longestSide;
    }

    double get shortestSide {
        return _size!.shortestSide;
    }

    double restricted({ required double size, required double maxSize }) {
        double restricted = (size >= maxSize) ? maxSize : size;
        debugPrint("Scale: Restricted Size(Size: $size Max: $maxSize)");
        return restricted;
    }

    double restrictedByTarget({ required double size, required double ratio }) {
        double ratedSize = size * ratio;
        double ratedTargetSize = targetSize * ratio;
        double restricted = (ratedSize >= ratedTargetSize) ? ratedTargetSize : ratedSize;
        return restricted;
    }

}