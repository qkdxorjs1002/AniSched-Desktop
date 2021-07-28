import 'package:anisched/arch/observable.dart';
import 'package:anisched/repository/anissia/model.dart';
import 'package:anisched/ui/page/search/item/item.dart';
import 'package:anisched/ui/page/search/provider.dart';
import 'package:anisched/ui/widget/blur.dart';
import 'package:anisched/ui/widget/sizes.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
    
    SearchPage({ Key? key }) : super(key: key);

    @override
    _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

    final SearchDataProvider dataProvider = SearchDataProvider();
    final ScrollController scrollController = ScrollController();
    
    List<AutoCorrect>? _autoCorrectList;
    AllAnime _allAnime = AllAnime();

    bool isAutoCorrect = false;

    @override
    void dispose() {
        scrollController.dispose();
        super.dispose();
    }

    @override
    void initState() {
        super.initState();
        initObservers();
        initEvents();
        dataProvider.requestAllSchedule(0, "");
    }

    void initObservers() {
        dataProvider.getAutoCorrectList!.addObserver(Observer((data) {
            setState(() {
                _autoCorrectList = data;
                isAutoCorrect = true;
            });
        }));

        dataProvider.getAnimeList!.addObserver(Observer((data) {
            setState(() {
                _allAnime = data;
                isAutoCorrect = false;
            });
        }));
    }

    void initEvents() {
        scrollController.addListener(() {
            final ScrollPosition scrollPosition = scrollController.position;
            if (scrollPosition.pixels >= scrollPosition.maxScrollExtent - Sizes.SIZE_060!) {
                dataProvider.requestAllScheduleNext();
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        Sizes.initialize(context);
        
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
                            padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_024!),
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
                                                                dataProvider.requestAutoCorrect(value);
                                                            } else {
                                                                setState(() {
                                                                    isAutoCorrect = false;
                                                                });
                                                            }
                                                        },
                                                        onSubmitted: (value) => dataProvider.requestAllSchedule(0, value),
                                                        maxLines: 1,
                                                    ),
                                                ),
                                            ),
                                        ],
                                    ),
                                    Divider(),
                                    Expanded(
                                        child: IndexedStack(
                                            index: (isAutoCorrect) ? 1 : 0,
                                            children: [
                                                (_allAnime.content != null) && (_allAnime.content!.isNotEmpty) ? ListView.separated(
                                                    controller: scrollController,
                                                    itemCount: _allAnime.content!.length,
                                                    itemBuilder: (context, index) => SearchItem(anime: _allAnime.content![index]),
                                                    separatorBuilder: (context, index) => Divider(),
                                                ) : _noList(),
                                            ] + ((_autoCorrectList != null) && (_autoCorrectList!.isNotEmpty) 
                                                ? [
                                                    ListView.separated(
                                                        itemCount: _autoCorrectList!.length,
                                                        itemBuilder: (context, index) => AutoCorrectItem(autoCorrect: _autoCorrectList![index]),
                                                        separatorBuilder: (context, index) => Divider(),
                                                    )
                                                ] : []
                                            ),
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
                padding: EdgeInsets.symmetric(vertical: Sizes.SIZE_010!, horizontal: Sizes.SIZE_020!),
                child: Text(
                    "검색어를 입력해주세요.",
                    style: TextStyle(
                        fontSize: Sizes.SIZE_012,
                        fontWeight: FontWeight.w300,
                    ),
                ),
            ),
        );
    }
}