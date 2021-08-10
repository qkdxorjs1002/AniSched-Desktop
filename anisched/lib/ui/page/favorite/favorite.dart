import 'package:anisched/arch/observable.dart';
import 'package:anisched/helper.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/detail/detail.dart';
import 'package:anisched/ui/page/favorite/provider.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/timetable/timetable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavoritePage extends StatefulWidget {
    
    FavoritePage({ Key? key }) : super(key: key);

    @override
    _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {

    final Map<String, String> _SORT_MODE_LIST = {
        "추가 순": "  +  ",
        "가나다 순": "  A  ",
        "방영일자 순": "  D  ",
        "추가 순 (역정렬)": " R+ ",
        "가나다 순 (역정렬)": " RA ",
        "방영일자 순 (역정렬)": " RD "
    };

    final FavoriteDataProvider dataProvider = FavoriteDataProvider();

    List<Anime>? _favList; 

    int _sortMode = 0;

    @override
    void initState() {
        super.initState();
        initObservers();
        dataProvider.requestFavoriteSortMode();
    }

    void initObservers() {
        dataProvider.getFavList!.addObserver(Observer((data) {
            setState(() {
                _favList = data;
            });
        }));
        
        dataProvider.getSortMode!.addObserver(Observer((data) {
            setState(() {
                _sortMode = data;
            });
            dataProvider.requestFavoriteList(_sortMode);
        }));
    }

    @override
    Widget build(BuildContext context) {
        Sizes.calculate(context);
        
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: BackBlur(
                child: Container(
                    alignment: Alignment.topCenter,
                    child: Padding(
                        padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_024),
                        child: Column(
                            children: [
                                ConstrainedBox(
                                    constraints: BoxConstraints(
                                        maxWidth: 750,
                                    ),
                                    child: Row(
                                        children: [
                                            Container(
                                                child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        onTap: () => Navigator.pop(context),
                                                        child: Icon(
                                                            Icons.arrow_back_ios_rounded,
                                                            size: Sizes.SIZE_024,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            Expanded(
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_006),
                                                    child: Text(
                                                        "즐겨찾기",
                                                        style: TextStyle(
                                                            fontSize: Sizes.SIZE_016,
                                                            fontWeight: FontWeight.w500,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            Padding(
                                                padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_006),
                                                child: Container(
                                                    child: Material(
                                                        color: Colors.transparent,
                                                        child: InkWell(
                                                            child: Icon(
                                                                Icons.delete_forever_rounded,
                                                                size: Sizes.SIZE_024,
                                                            ),
                                                            onTap: () => Helper.snack(
                                                                context, 
                                                                text: "추가한 모든 즐겨찾기 항목을 제거합니다. 이 작업은 되돌릴 수 없습니다.", 
                                                                label: "목록 제거",
                                                                onPressed: () {
                                                                    dataProvider.requestRemoveFavoriteList();
                                                                    ScaffoldMessenger.of(context).showSnackBar(
                                                                        SnackBar(
                                                                            backgroundColor: Theme.of(context).backgroundColor,
                                                                            content: Text(
                                                                                "즐겨찾기 목록을 제거했습니다.",
                                                                                style: TextStyle(
                                                                                    color: Theme.of(context).primaryColor,
                                                                                    fontWeight: FontWeight.w300,
                                                                                ),
                                                                            ),
                                                                        ),
                                                                    );
                                                                },
                                                            ),
                                                        ),
                                                    ),
                                                ),
                                            ),
                                            Container(
                                                child: Material(
                                                    color: Colors.transparent,
                                                    child: InkWell(
                                                        onTap: () {
                                                            dataProvider.requestSetFavoriteSortMode((_sortMode + 1) % _SORT_MODE_LIST.values.length);
                                                        },
                                                        child: Stack(
                                                            alignment: Alignment.bottomRight,
                                                            children: [
                                                                Icon(
                                                                    Icons.sort_rounded,
                                                                    size: Sizes.SIZE_024,
                                                                ),
                                                                Padding(
                                                                    padding: EdgeInsets.only(bottom: Sizes.SIZE_004),
                                                                    child: Text(
                                                                        _SORT_MODE_LIST.values.toList()[_sortMode],
                                                                        style: TextStyle(
                                                                            color: Theme.of(context).backgroundColor,
                                                                            backgroundColor: Theme.of(context).primaryColor,
                                                                            fontSize: Sizes.SIZE_008,
                                                                            fontWeight: FontWeight.w500,
                                                                            height: 1.0,
                                                                        ),
                                                                    ),
                                                                ),
                                                            ],
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                                Expanded(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                            Padding(
                                                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_008, horizontal: Sizes.SIZE_024),
                                                child: Text(
                                                    _SORT_MODE_LIST.keys.toList()[_sortMode],
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_020,
                                                        fontWeight: FontWeight.w500,
                                                    ),
                                                ),
                                            ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: (_favList != null && _favList!.isNotEmpty) ? TimeTable.list(
                                                    animeList: _favList,
                                                    height: Sizes.SIZE_400,
                                                    onItemClick: (anime, tmdb) => Helper.navigateRoute(context, DetailPage(animeId: anime.id)),
                                                ) : Text(
                                                    "목록 없음",
                                                    style: TextStyle(
                                                        fontSize: Sizes.SIZE_015,
                                                        fontWeight: FontWeight.w300,
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
            ),
        );
    }
}