import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/search/item/item.dart';
import 'package:anisched/ui/page/search/provider.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:anisched/ui/widget/smoothscroll.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
    
    SearchPage({ Key? key }) : super(key: key);

    @override
    _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

    final SearchDataProvider _dataProvider = SearchDataProvider();
    final ScrollController _autoScrollController = ScrollController();
    final ScrollController _scrollController = ScrollController();
    
    List<AutoCorrect>? _autoCorrectList;
    AllAnime _allAnime = AllAnime();

    bool _isAutoCorrect = false;

    @override
    void dispose() {
        _scrollController.dispose();
        super.dispose();
    }

    @override
    void initState() {
        super.initState();
        initObservers();
        initEvents();
        _dataProvider.requestAllSchedule(0, "");
    }

    void initObservers() {
        _dataProvider.getAutoCorrectList!.addObserver(Observer((data) {
            setState(() {
                _autoCorrectList = data;
                _isAutoCorrect = true;
            });
        }));

        _dataProvider.getAnimeList!.addObserver(Observer((data) {
            setState(() {
                _allAnime = data;
                _isAutoCorrect = false;
            });
        }));
    }

    void initEvents() {
        _scrollController.addListener(() {
            final ScrollPosition scrollPosition = _scrollController.position;
            if (scrollPosition.pixels >= scrollPosition.maxScrollExtent - Sizes.SIZE_060) {
                _dataProvider.requestAllScheduleNext();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        Sizes.calculate(context);
        
        return Scaffold(
            backgroundColor: Colors.transparent,
            body: BackBlur(
                child: Container(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: 750,
                        ),
                        child: Padding(
                            padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_024),
                            child: Column(
                                children: [
                                    Row(
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
                                                    child: TextField(
                                                        cursorColor: Theme.of(context).primaryColor,
                                                        decoration: InputDecoration(
                                                            hintText: "검색어",
                                                            border: InputBorder.none,
                                                            focusColor: Theme.of(context).primaryColor,
                                                            focusedBorder: InputBorder.none,
                                                        ),
                                                        style: TextStyle(
                                                            fontSize: Sizes.SIZE_016,
                                                            fontWeight: FontWeight.w500,
                                                        ),
                                                        onChanged: (value) {
                                                            if (value != "") {
                                                                _dataProvider.requestAutoCorrect(value);
                                                            } else {
                                                                setState(() {
                                                                    _isAutoCorrect = false;
                                                                });
                                                            }
                                                        },
                                                        onSubmitted: (value) => _dataProvider.requestAllSchedule(0, value),
                                                        maxLines: 1,
                                                    ),
                                                ),
                                            ),
                                            Align(
                                                alignment: Alignment.center,
                                                child: Padding(
                                                    padding: EdgeInsets.symmetric(horizontal: Sizes.SIZE_020),
                                                    child: Text(
                                                        ((!_isAutoCorrect) ? _allAnime.totalElements : _autoCorrectList!.length).toString() + " 항목",
                                                        style: TextStyle(
                                                            fontSize: Sizes.SIZE_016,
                                                        ),
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                    Divider(),
                                    Expanded(
                                        child: IndexedStack(
                                            index: (_isAutoCorrect) ? 1 : 0,
                                            children: [
                                                ((_allAnime.content != null) && (_allAnime.content!.isNotEmpty))
                                                    ? SmoothScroll(
                                                        child: ListView.separated(
                                                            controller: _scrollController,
                                                            physics: const SmoothScrollPhysics(),
                                                            itemCount: _allAnime.content!.length,
                                                            itemBuilder: (context, index) => SearchItem(anime: _allAnime.content![index]),
                                                            separatorBuilder: (context, index) => Divider(),
                                                        )
                                                    ) : _noList(),
                                                ((_autoCorrectList != null) && (_autoCorrectList!.isNotEmpty))
                                                    ? SmoothScroll(
                                                        child: ListView.separated(
                                                            controller: _autoScrollController,
                                                            physics: const SmoothScrollPhysics(),
                                                            itemCount: _autoCorrectList!.length,
                                                            itemBuilder: (context, index) => AutoCorrectItem(autoCorrect: _autoCorrectList![index]),
                                                            separatorBuilder: (context, index) => Divider(),
                                                        )
                                                    ) : _noList(),
                                            ],
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ),
                ),
            ),
        );
    }

    Widget _noList() {
        return Container(
            alignment: Alignment.topCenter,
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010, horizontal: Sizes.SIZE_020),
                child: Text(
                    "검색 결과가 없습니다.",
                    style: TextStyle(
                        fontSize: Sizes.SIZE_012,
                        fontWeight: FontWeight.w300,
                    ),
                ),
            ),
        );
    }
}