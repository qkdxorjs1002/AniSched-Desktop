import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Sizes {

    static double SIZE_002;
    static double SIZE_004;
    static double SIZE_006;
    static double SIZE_008;
    static double SIZE_010;
    static double SIZE_012;
    static double SIZE_014;
    static double SIZE_015;
    static double SIZE_016;
    static double SIZE_020;
    static double SIZE_024;
    static double SIZE_030;
    static double SIZE_040;
    static double SIZE_060;
    static double SIZE_080;
    static double SIZE_120;
    static double SIZE_170;
    static double SIZE_210;
    static double SIZE_240;
    static double SIZE_280;
    static double SIZE_300;
    static double SIZE_400;
    static double SIZE_560;

    static void initialize(BuildContext context) {
        final Scale scale = Scale(context);

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