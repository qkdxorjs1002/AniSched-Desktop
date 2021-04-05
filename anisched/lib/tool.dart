import 'package:url_launcher/url_launcher.dart';
import 'dart:math';

class Tool {
    static void openURL(String url) async {
        if (url != null && url.isNotEmpty) {
            await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
        }
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