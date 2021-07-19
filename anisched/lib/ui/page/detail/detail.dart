import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/tool.dart';
import 'package:anisched/ui/page/detail/item/description.dart';
import 'package:anisched/ui/page/detail/model.dart';
import 'package:anisched/ui/page/detail/provider.dart';
import 'package:anisched/ui/widget/backdrop.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/captions/captions.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/season/season.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {

    final int animeId;
    
    const DetailPage({ Key key, this.animeId }) : super(key: key);

    @override
    _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {

    final DetailDataProvider dataProvider = DetailDataProvider();
    
    Anime anime;
    TMDBDetail tmdbDetail;

    bool isBackdropHover = false;

    @override
    void initState() {
        super.initState();
        initObservers();
        
        dataProvider.requestAnimeInfo(widget.animeId);
    }

    void initObservers() {
        dataProvider.getAnimeInfo.addObserver(Observer((data) {
            setState(() {
                anime = data;
            });
            dataProvider.requestTMDB(data);
        }));

        dataProvider.getTMDBDetail.addObserver(Observer((data) {
            setState(() {
                tmdbDetail = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        Sizes.initialize(context);
        
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: BackBlur(
                child: (anime != null) ? ListView(
                    physics: const ClampingScrollPhysics(),
                    children: [
                        Container(
                            color: Theme.of(context).backgroundColor.withOpacity(0.54),
                            height: Sizes.SIZE_400,
                            child: Stack(
                                children: [
                                    Backdrop(
                                        panelHeight: Sizes.SIZE_080,
                                        imageUrl: (tmdbDetail != null) 
                                            ? tmdbDetail.media.getBackdropPath(TMDBImageSizes.ORIGINAL)
                                            : null,
                                        title: anime.subject,
                                        time: FACTOR.WEEKDAY[anime.week],
                                        extra: anime.getExtraInfo,
                                    ),
                                    Visibility(
                                        visible: isBackdropHover,
                                        child: Container(
                                            color: Theme.of(context).backgroundColor.withOpacity(0.35),
                                            child: Center(
                                                child: Text(
                                                    "⮐",
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_060,
                                                    ),
                                                ),
                                            ),
                                        ),
                                    ),
                                    Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () => Navigator.pop(context),
                                            onHover: (value) {
                                                setState(() {
                                                    isBackdropHover = value;
                                                });
                                            },
                                            hoverColor: Colors.transparent,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                        Container(
                            alignment: Alignment.topCenter,
                            child: ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth: 750,
                                ),
                                child: Padding(
                                    padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_030),
                                    child: Column(
                                        children: <Widget> [
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_020),
                                                child: Description(
                                                    anime: anime,
                                                    tmdbDetail: tmdbDetail
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: Sizes.SIZE_020),
                                                child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        onTap: () async => Tool.openURL(anime.website),
                                                        child: Container(
                                                            width: double.infinity,
                                                            child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_012, horizontal: Sizes.SIZE_020),
                                                                child: Row(
                                                                    children: [
                                                                        Expanded(
                                                                            child: Text(
                                                                                "사이트 바로가기",
                                                                                style: TextStyle(
                                                                                    fontSize: Sizes.SIZE_016,
                                                                                    fontWeight: FontWeight.w700,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                        Text(
                                                                            "〉",
                                                                            style: TextStyle(
                                                                                fontSize: Sizes.SIZE_016,
                                                                                fontWeight: FontWeight.w700,
                                                                            ),
                                                                        ),
                                                                    ],
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ] + ((tmdbDetail != null && tmdbDetail.type == TMDBMediaTypes.TV) 
                                            ? [
                                                Padding(
                                                    padding: EdgeInsets.only(top: Sizes.SIZE_020, left: Sizes.SIZE_020, right: Sizes.SIZE_020),
                                                    child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                            Text(
                                                                "시즌 목록",
                                                                style: TextStyle(
                                                                    fontSize: Sizes.SIZE_016,
                                                                    fontWeight: FontWeight.w700,
                                                                ),
                                                            ),
                                                            const Divider(),
                                                        ],
                                                    ),
                                                ),
                                                SeasonTable(
                                                    seasonList: (tmdbDetail.media as TV).seasonList.reversed.toList(),
                                                ),
                                            ] 
                                            : [])
                                        + [
                                            Padding(
                                                padding: EdgeInsets.only(top: Sizes.SIZE_020),
                                                child: Captions(
                                                    captionList: anime.captionList,
                                                    onItemClick: (Caption caption) async => Tool.openURL(caption.website),
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: Sizes.SIZE_020),
                                                child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        onTap: () async => Tool.openURL("https://namu.wiki/go/${anime.subject}"),
                                                        child: Container(
                                                            width: double.infinity,
                                                            child: Padding(
                                                                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_012, horizontal: Sizes.SIZE_020),
                                                                child: Row(
                                                                    children: [
                                                                        Expanded(
                                                                            child: Text(
                                                                                "나무위키 바로가기",
                                                                                style: TextStyle(
                                                                                    fontSize: Sizes.SIZE_016,
                                                                                    fontWeight: FontWeight.w700,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                        Text(
                                                                            "〉",
                                                                            style: TextStyle(
                                                                                fontSize: Sizes.SIZE_016,
                                                                                fontWeight: FontWeight.w700,
                                                                            ),
                                                                        ),
                                                                    ],
                                                                ),
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ),
                        ),
                    ],
                ) : LoadingIndicator(),
            ),
        );
    }
}