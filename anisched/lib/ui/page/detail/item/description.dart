import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/page/detail/model.dart';
import 'package:anisched/ui/widget/image.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class Description extends StatelessWidget {

    final Anime anime;
    final TMDBDetail tmdbDetail;

    const Description({ this.anime, this.tmdbDetail });

    @override
    Widget build(BuildContext context) {
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
                                    ),
                                    _contentText(
                                        text: anime.getTimeString,
                                    ),
                                    _headerText(
                                        text: "방영 시작",
                                    ),
                                    _contentText(
                                        text: anime.getStartDateString,
                                    ),
                                    _headerText(
                                        text: "종영",
                                    ),
                                    _contentText(
                                        text: anime.getEndDateString,
                                    ),
                                    _headerText(
                                        text: "장르",
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(bottom: Sizes.SIZE_016),
                                        child: Wrap(
                                            children: anime.getGenreList.map((e) {
                                                return Padding(
                                                    padding: EdgeInsets.only(top: Sizes.SIZE_004, right: Sizes.SIZE_008),
                                                    child: Chip(
                                                        backgroundColor: Colors.white,
                                                        elevation: 0,
                                                        padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_006, horizontal: Sizes.SIZE_010),
                                                        labelPadding: EdgeInsets.zero,
                                                        label: Text(
                                                            e,
                                                            style: TextStyle(
                                                                color: Colors.black,
                                                                fontSize: Sizes.SIZE_012,
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
                                width: Sizes.SIZE_170,
                                height: Sizes.SIZE_240,
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
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getTitle,
                    ),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getOriginalTitle,
                    ),
                    _headerText(
                        text: "시청자 평점",
                    ),
                    Divider(),
                    _content(
                        child: LinearProgressIndicator(
                            backgroundColor: Colors.white12,
                            color: Colors.white70,
                            value: (tmdbDetail.media as TMDBMediaInterface).getVoteDouble,
                        ),
                    ),
                    _content(
                        padding: EdgeInsets.only(top: Sizes.SIZE_002),
                        child: Row(
                            children: [
                                Expanded(
                                    child: Text(
                                        (tmdbDetail.media as TMDBMediaInterface).getVoteCountString,
                                        style: TextStyle(
                                            fontSize: Sizes.SIZE_014,
                                        ),
                                    ),
                                ),
                                Text(
                                    "${(tmdbDetail.media as TMDBMediaInterface).getVoteDecimal}점",
                                    style: TextStyle(
                                        fontSize: Sizes.SIZE_014,
                                    ),
                                ),
                            ],
                        ),
                    ),
                    _headerText(
                        text: "줄거리",
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getOverview,
                    ),
                ] + ((tmdbDetail.type == TMDBMediaTypes.TV) 
                    ? [
                        _headerText(
                            text: "방영사",
                        ),
                        Divider(),
                        _contentText(
                            text: (tmdbDetail.media as TV).getNetworksString,
                        ),
                    ] 
                    : []) 
                + [
                    _headerText(
                        text: "제작사",
                    ),
                    Divider(),
                    _contentText(
                        text: (tmdbDetail.media as TMDBMediaInterface).getProductionsString,
                    ),
                ]
                : []
            ),
        ) : LoadingIndicator();
    }

    Widget _header({ @required Widget child }) {
        return Padding(
            padding: EdgeInsets.only(top: Sizes.SIZE_020),
            child: child,
        );
    }

    Widget _headerText({ @required String text }) {
        return _header(
            child: Text(
                text,
                style: TextStyle(
                    fontSize: Sizes.SIZE_016,
                    fontWeight: FontWeight.w700,
                ),
            ),
        );
    }
    
    Widget _content({ @required Widget child, EdgeInsets padding = EdgeInsets.zero}) {
        return Padding(
            padding: padding,
            child: child,
        );
    }

    Widget _contentText({ @required String text }) {
        return _content(
            child: Text(
                text,
                style: TextStyle(
                    fontSize: Sizes.SIZE_015,
                    fontWeight: FontWeight.w300,
                ),
            ),
        );
    }
    
}
