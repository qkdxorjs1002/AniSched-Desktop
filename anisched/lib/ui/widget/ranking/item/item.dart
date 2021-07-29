import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/repository/tmdb/model.dart';
import 'package:anisched/ui/widget/backdrop.dart';
import 'package:anisched/ui/widget/loading.dart';
import 'package:anisched/ui/widget/ranking/item/provider.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class RankingItem extends StatefulWidget {

    final Rank rank;

    final Function? onItemClick;

    const RankingItem({ required this.rank, this.onItemClick, key }) : super(key: key);

    @override
    _RankingItemState createState() => _RankingItemState();
}

class _RankingItemState extends State<RankingItem> with AutomaticKeepAliveClientMixin{

    final RankingItemDataProvider _dataProvider = RankingItemDataProvider();
    
    Anime? _anime;
    Result? _tmdbResult;

    @override
    void initState() {
        super.initState();
        initObservers();

        _dataProvider.requestAnime(widget.rank.id);
    }

    void initObservers() {
        _dataProvider.getAnimeInfo!.addObserver(Observer((Anime data) {
            setState(() {
                _anime = data;
                _dataProvider.requestTMDB(data);
            });
        }));

        _dataProvider.getTMDBResult!.addObserver(Observer((Result data) {
            setState(() {
                _tmdbResult = data;
            });
        }));
    }

    @override
    Widget build(BuildContext context) {
        super.build(context);
        
        return (_anime != null) ? Stack(
            children: [
                Backdrop(
                    panelHeight: Sizes.SIZE_120,
                    imageUrl: (_tmdbResult != null) 
                        ? _tmdbResult!.getBackdropPath(TMDBImageSizes.ORIGINAL)
                        : null,
                    title: widget.rank.subject,
                    description: "${widget.rank.rankString} ᐧ ${widget.rank.diffString}",
                    time: AnissiaFactor.WEEKDAY[_anime!.week!],
                    extra: _anime!.getGenreString,
                ),
                Material(
                    color: Colors.transparent,
                    child: InkWell(
                        onTap: () => widget.onItemClick!(_anime, _tmdbResult),
                        hoverColor: Colors.transparent,
                    ),
                ),
            ],
        ) : LoadingIndicator();
    }

  @override
  bool get wantKeepAlive => true;
}
