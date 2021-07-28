import 'package:anisched/ui/widget/blur.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class Helper {
    static void openURL(String url) async {
        String encodedUrl = Uri.encodeFull(url);
        await canLaunch(encodedUrl) ? await launch(encodedUrl) : throw 'Could not launch $encodedUrl';
    }

    static void navigateRoute(BuildContext context, Widget child) {
        Navigator.of(context).push(
            PageRouteBuilder(
                opaque: false,
                transitionDuration: const Duration(milliseconds: 500),
                pageBuilder: (context, animation, secondaryAnimation) => BlurTransition(
                    animation: Tween<double>(begin: 30.0, end: 0.0).animate(animation),
                    child: child,
                ),
            ),
        );
    }
}

class Levenshtein {

    static double getDistance(String a, String b) {
        a = a.toLowerCase();
        b = b.toLowerCase();

        if (a.length < b.length) {
            String tmp = a;
            a = b;
            b = tmp;
        }

        int aLength = a.length;
        if (aLength == 0) {
            return 1.0;
        }

        List<int> costs = List.filled(b.length + 1, -1);

        for (int j = 0; j < costs.length; j++) {
            costs[j] = j;
        }

        for (int i = 1; i <= a.length; i++) {
            costs[0] = i;
            int nw = i - 1;

            for (int j = 1; j <= b.length; j++) {
                int cj = min(1 + min(costs[j], costs[j - 1]), a[i - 1] == b[j - 1] ? nw : nw + 1);
                nw = costs[j];
                costs[j] = cj;
            }
        }

        return (aLength - costs[b.length]) / aLength.toDouble();
    }

}