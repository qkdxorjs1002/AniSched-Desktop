import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/page/detail/model.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {

    final Anime anime;
    final TMDBDetail tmdbDetail;

    const Description({ this.anime, this.tmdbDetail });

    @override
    Widget build(BuildContext context) {
        final Scale scale = Scale(context);

        return (anime != null) ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Divider(),
                Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                        Expanded(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                    _headerText(
                                        text: "시간",
                                        scale: scale
                                    ),
                                    _contentText(
                                        text: anime.getTimeString,
                                        scale: scale
                                    ),
                                    _headerText(
                                        text: "방영 시작",
                                        scale: scale
                                    ),
                                    _contentText(
                                        text: anime.getStartDateString,
                                        scale: scale
                                    ),
                                    _headerText(
                                        text: "종영",
                                        scale:scale
                                    ),
                                    _contentText(
                                        text: anime.getEndDateString,
                                        scale: scale
                                    ),
                                    _headerText(
                                        text: "장르",
                                        scale: scale
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: scale.longestSide * 0.016),
                                        child: Wrap(
                                            children: anime.getGenreList.map((e) {
                                                return Padding(
                                                    padding: EdgeInsets.only(top: scale.longestSide * 0.004, right: scale.longestSide * 0.008),
                                                    child: Chip(
                                                        backgroundColor: Colors.white,
                                                        elevation: 0,
                                                        padding: EdgeInsets.symmetric(vertical: scale.longestSide * 0.006, horizontal: scale.longestSide * 0.01),
                                                        labelPadding: EdgeInsets.zero,
                                                        label: Text(
                                                            e,
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: scale.longestSide * 0.012,
                                                            ),
                                                        ),
                                                    ),
                                                );
                                            }).toList(),
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Container(
                            alignment: Alignment.center,
                            child: Container(
                                color: Colors.black26,
                                width: scale.longestSide * 0.17,
                                height: scale.longestSide * 0.24,
                                child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                        ImageNetwork(
                                            source: (tmdbDetail != null) ? tmdbDetail.media.getPosterPath(TMDBImageSizes.W500) : null,
                                        ),
                                    ],
                                ),
                            ),
                        ),
                    ],
                ),
                Divider(),
            ] + ((tmdbDetail != null) 
                ? [
                    _headerText(
                        text: "제목",
                        scale: scale
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getTitle,
                        scale: scale
                    ),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getOriginalTitle,
                        scale: scale
                    ),
                    _headerText(
                        text: "시청자 평점",
                        scale: scale
                    ),
                    Divider(),
                    _content(
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.white12,
                            color: Colors.white70,
                            value: (tmdbDetail.media as TMDBMediaInterface).getVoteDouble,
                        ),
                        scale: scale
                    ),
                    _content(
                        padding: EdgeInsets.only(top: scale.longestSide * 0.002),
                        child: Row(
                            children: [
                                Expanded(
                                    child: Text(
                                        (tmdbDetail.media as TMDBMediaInterface).getVoteCountString,
                                        style: TextStyle(
                                            fontSize: scale.longestSide * 0.014,
                                        ),
                                    ),
                                ),
                                Text(
                                    "${(tmdbDetail.media as TMDBMediaInterface).getVoteDecimal}점",
                                    style: TextStyle(
                                        fontSize: scale.longestSide * 0.014,
                                    ),
                                ),
                            ],
                        ),
                        scale: scale
                    ),
                    _headerText(
                        text: "줄거리",
                        scale: scale
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getOverview,
                        scale: scale
                    ),
                ] + ((tmdbDetail.type == TMDBMediaTypes.TV) 
                    ? [
                        _headerText(
                            text: "방영사",
                            scale: scale
                        ),
                        Divider(),
                        _contentText(
                            text: (tmdbDetail.media as TV).getNetworksString,
                            scale: scale
                        ),
                    ] 
                    : []) 
                + [
                    _headerText(
                        text: "제작사",
                        scale: scale
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getProductionsString,
                        scale: scale
                    ),
                ]
                : []
            ),
        ) : LoadingIndicator();
    }

    Widget _header({ @required Widget child, @required Scale scale }) {
        return Padding(
            padding: EdgeInsets.only(top: scale.longestSide * 0.02),
            child: child,
        );
    }

    Widget _headerText({ @required String text, @required Scale scale }) {
        return _header(
            child: Text(
                text,
                style: TextStyle(
                    fontSize: scale.longestSide * 0.016,
                    fontWeight: FontWeight.w700,
                ),
            ),
            scale: scale
        );
    }
    
    Widget _content({ @required Widget child, @required Scale scale, EdgeInsets padding = EdgeInsets.zero}) {
        return Padding(
            padding: padding,
            child: child,
        );
    }

    Widget _contentText({ @required String text, @required Scale scale }) {
        return _content(
            child: Text(
                text,
                style: TextStyle(
                    fontSize: scale.longestSide * 0.015,
                    fontWeight: FontWeight.w300,
                ),
            ),
            scale: scale,
        );
    }
    
}
