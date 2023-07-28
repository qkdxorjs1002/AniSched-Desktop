// ignore_for_file: non_constant_identifier_names

import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Sizes {

    static late double SIZE_002;
    static late double SIZE_004;
    static late double SIZE_006;
    static late double SIZE_008;
    static late double SIZE_010;
    static late double SIZE_012;
    static late double SIZE_014;
    static late double SIZE_015;
    static late double SIZE_016;
    static late double SIZE_020;
    static late double SIZE_024;
    static late double SIZE_030;
    static late double SIZE_040;
    static late double SIZE_060;
    static late double SIZE_080;
    static late double SIZE_120;
    static late double SIZE_170;
    static late double SIZE_210;
    static late double SIZE_240;
    static late double SIZE_280;
    static late double SIZE_300;
    static late double SIZE_400;
    static late double SIZE_560;
    
    static Size? _size;

    static void calculate(BuildContext context) {
        final Scale scale = Scale(context);

        if (scale.size == _size) {
            return ;
        } else {
            _size = scale.size;
        }

        SIZE_002 = scale.restrictedByTarget(size: scale.width, ratio: 0.002);
        SIZE_004 = scale.restrictedByTarget(size: scale.width, ratio: 0.004);
        SIZE_006 = scale.restrictedByTarget(size: scale.width, ratio: 0.006);
        SIZE_008 = scale.restrictedByTarget(size: scale.width, ratio: 0.008);
        SIZE_010 = scale.restrictedByTarget(size: scale.width, ratio: 0.010);
        SIZE_012 = scale.restrictedByTarget(size: scale.width, ratio: 0.012);
        SIZE_014 = scale.restrictedByTarget(size: scale.width, ratio: 0.014);
        SIZE_015 = scale.restrictedByTarget(size: scale.width, ratio: 0.015);
        SIZE_016 = scale.restrictedByTarget(size: scale.width, ratio: 0.016);
        SIZE_020 = scale.restrictedByTarget(size: scale.width, ratio: 0.020);
        SIZE_024 = scale.restrictedByTarget(size: scale.width, ratio: 0.024);
        SIZE_030 = scale.restrictedByTarget(size: scale.width, ratio: 0.030);
        SIZE_040 = scale.restrictedByTarget(size: scale.width, ratio: 0.040);
        SIZE_060 = scale.restrictedByTarget(size: scale.width, ratio: 0.060);
        SIZE_080 = scale.restrictedByTarget(size: scale.width, ratio: 0.080);
        SIZE_120 = scale.restrictedByTarget(size: scale.width, ratio: 0.120);
        SIZE_170 = scale.restrictedByTarget(size: scale.width, ratio: 0.170);
        SIZE_210 = scale.restrictedByTarget(size: scale.width, ratio: 0.210);
        SIZE_240 = scale.restrictedByTarget(size: scale.width, ratio: 0.240);
        SIZE_280 = scale.restrictedByTarget(size: scale.width, ratio: 0.280);
        SIZE_300 = scale.restrictedByTarget(size: scale.width, ratio: 0.300);
        SIZE_400 = scale.restrictedByTarget(size: scale.width, ratio: 0.400);
        SIZE_560 = scale.restrictedByTarget(size: scale.width, ratio: 0.560);
    }
}