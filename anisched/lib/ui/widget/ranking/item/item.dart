import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/backdrop.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/ranking/item/provider.dart';
import 'package:anisched/ui/widget/scale.dart';
import 'package:flutter/material.dart';

class RankingItem extends StatefulWidget {

    final Rank rank;

    final Function onItemClick;

    const RankingItem({ @required this.rank, this.onItemClick, key }) : super(key: key);

    @override
    _RankingItemState createState() => _RankingItemState();
}

class _RankingItemState extends State<RankingItem> with AutomaticKeepAliveClientMixin{

    final RankingItemDataProvider dataProvider = RankingItemDataProvider();
    
    Anime anime;
    Result tmdbResult;

    @override
    void initState() {
        super.initState();
        initObservers();

        dataProvider.requestAnime(widget.rank.id);
    }

    void initObservers() {
        dataProvider.getAnimeInfo.addObserver(Observer((Anime data) {
            setState(() {
                anime = data;
                dataProvider.requestTMDB(data);
            });
        }));

        dataProvider.getTMDBResult.addObserver(Observer((Result data) {
            setState(() {
                tmdbResult = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);

        Scale scale = Scale(context);

        return (anime != null) ? Stack(
            children: [
                Backdrop(
                    panelHeight: scale.actualLongestSide * 0.06,
                    imageUrl: (tmdbResult != null) 
                        ? tmdbResult.getBackdropPath(scale.actualLongestSide > 1280 ? Result.ORIGINAL : Result.W1280)
                        : null,
                    title: widget.rank.subject,
                    description: "${widget.rank.rankString} • ${widget.rank.diffString}",
                    time: FACTOR.WEEKDAY[anime.week],
                    extra: anime.getGenreString,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () => widget.onItemClick(anime, tmdbResult),
                        hoverColor: Colors.transparent,
                    ),
                ),
            ],
        ) : LoadingIndicator();
    }

  @override
  bool get wantKeepAlive => true;
}