import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageNetwork extends StatelessWidget {

    final String source;
    final double width;
    final double height;

    ImageNetwork(this.source, {this.width, this.height});

    @override
    Widget build(BuildContext context) {
        return Image(
            image: CachedNetworkImageProvider(source),
            width: width == null ? null : width,
            height: height == null ? null : height,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            gaplessPlayback: true,
            loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                    return child;
                }
                return Center(
                    child: CircularProgressIndicator(
                        strokeWidth: 1,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.black12),
                        backgroundColor: Colors.white70,
                        value: loadingProgress.expectedTotalBytes != null 
                            ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes 
                            : null,
                    ),
                );
            },
        );
    }

}