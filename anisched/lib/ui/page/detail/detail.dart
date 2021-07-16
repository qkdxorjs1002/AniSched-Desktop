import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/tool.dart';
import 'package:anisched/ui/page/detail/item/description.dart';
import 'package:anisched/ui/page/detail/provider.dart';
import 'package:anisched/ui/widget/backdrop.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/captions/captions.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/scale.dart';
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
    Result tmdbResult;

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

        dataProvider.getTMDBResult.addObserver(Observer((data) {
            setState(() {
                tmdbResult = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {

        final Scale scale = Scale(context);

        return Scaffold(
            backgroundColor: Colors.transparent,
            body: BackBlur(
                child: (anime != null) ? ListView(
                    physics: ClampingScrollPhysics(),
                    children: [
                        Container(
                            color: Colors.black54,
                            height: scale.longestSide * 0.4,
                            child: Stack(
                                children: [
                                    Backdrop(
                                        imageUrl: (tmdbResult != null) 
                                            ? tmdbResult.getBackdropPath(Result.ORIGINAL)
                                        panelHeight: scale.longestSide * 0.08,
                                            : null,
                                        title: anime.subject,
                                        time: FACTOR.WEEKDAY[anime.week],
                                        extra: anime.getExtraInfo,
                                    ),
                                    Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () => Navigator.pop(context),
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
                                    padding: EdgeInsets.symmetric(vertical: scale.longestSide * 0.03),
                                    child: Column(
                                        children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: scale.longestSide * 0.02),
                                                child: Description(
                                                    anime: anime,
                                                    tmdbResult: tmdbResult,
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.only(top: scale.longestSide * 0.02),
                                                child: Captions(
                                                    captionList: anime.captionList,
                                                    onItemClick: (Caption caption) async => Tool.openURL(caption.website),
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