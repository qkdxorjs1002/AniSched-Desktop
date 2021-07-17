import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {

    final String source;
    final double width;
    final double height;

    ImageNetwork({ @required this.source, this.width, this.height });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return (source != null) ? CachedNetworkImage(
            imageUrl: source,
            width: width,
            height: height,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            progressIndicatorBuilder: (context, url, progress) => LoadingIndicator(value: progress.progress),
            errorWidget: (context, url, error) {
                return Center(
                    child: Text(
                        "NO IMAGE",
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.012),
                        ),
                    ),
                );
            },
        ) : Center(
            child: Text(
                "NO IMAGE",
                style: TextStyle(
                    color: Colors.white54,
                    fontSize: scale.restrictedByTarget(size: scale.width, ratio: 0.012),
                ),
            ),
        );
    }

}