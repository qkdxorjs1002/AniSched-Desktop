import 'package:anisched/repository/anissia/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnItemClickListener {
    
    final onItemClick;

    OnItemClickListener({ this.onItemClick });
    
}

class AnimeListView extends StatelessWidget {

    final List<Anime> list;

    final OnItemClickListener onItemClickListener;

    AnimeListView({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
            ),
            shrinkWrap: true,
            slivers: [
                SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: AnimeSliverList(
                        list: this.list,
                        onItemClickListener: onItemClickListener,
                    ),
                ),
            ],
        );
    }

}

class AnimeSliverList extends StatelessWidget {

    final List<Anime> list;

    final OnItemClickListener onItemClickListener;

    AnimeSliverList({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return SliverList(
            delegate: (list != null && list.length > 0)
            ?   SliverChildBuilderDelegate(
                    (context, index) {
                        return AnimeSliverChild(
                            anime: list[index],
                            onItemClickListener: onItemClickListener,
                        );
                    },
                    childCount: list.length,
                )
            :   SliverChildListDelegate(
                    [
                        Padding(
                            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                            child: Center(
                                child: Text("목록 없음")
                            ),
                        ),
                    ],
                )
        );
    }

}

class AnimeSliverChild extends StatelessWidget {

    final Anime anime;

    final OnItemClickListener onItemClickListener;

    AnimeSliverChild({ this.anime, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                    if (onItemClickListener != null) {
                        onItemClickListener.onItemClick(this.anime);
                    }
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: Column(
                        children: [
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text("${anime.subject}"),
                                        ),
                                    ),
                                ],
                            ),
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text("${anime.time} - ${anime.genreString}"),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text("${anime.extraInfo}"),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

}

class CaptionListView extends StatelessWidget {

    final List<Caption> list;

    final OnItemClickListener onItemClickListener;

    CaptionListView({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            shrinkWrap: true,
            slivers: [
                SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: CaptionSliverList(
                        list: this.list,
                        onItemClickListener: onItemClickListener,
                    ),
                ),
            ],
        );
    }

}

class CaptionSliverList extends StatelessWidget {

    final List<Caption> list;

    final OnItemClickListener onItemClickListener;

    CaptionSliverList({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return SliverList(
            delegate: (list != null && list.length > 0)
            ?   SliverChildBuilderDelegate(
                    (context, index) {
                        return CaptionSliverChild(
                            caption: list[index],
                            onItemClickListener: onItemClickListener,
                        );
                    },
                    childCount: list.length,
                )
            :   SliverChildListDelegate(
                    [
                        Padding(
                            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                            child: Center(
                                child: Text("목록 없음")
                            ),
                        ),
                    ],
                )
        );
    }

}

class CaptionSliverChild extends StatelessWidget {

    final Caption caption;

    final OnItemClickListener onItemClickListener;

    CaptionSliverChild({ this.caption, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                    if (onItemClickListener != null) {
                        onItemClickListener.onItemClick(this.caption);
                    }
                },
                child: Padding(
                    padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                    child: Column(
                        children: [
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomLeft,
                                            child: Text(""),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: Text(caption.author),
                                        ),
                                    ),
                                ],
                            ),
                            Row(
                                children: [
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(caption.episode),
                                        ),
                                    ),
                                    Expanded(
                                        child: Align(
                                            alignment: Alignment.topRight,
                                            child: Text(caption.uploadDate),
                                        ),
                                    ),
                                ],
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

}

class RankListView extends StatelessWidget {

    final List<Rank> list;

    final OnItemClickListener onItemClickListener;

    RankListView({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
            ),
            shrinkWrap: true,
            slivers: [
                SliverPadding(
                    padding: const EdgeInsets.all(0),
                    sliver: RankSliverList(
                        list: this.list,
                        onItemClickListener: onItemClickListener,
                    ),
                ),
            ],
        );
    }

}

class RankSliverList extends StatelessWidget {

    final List<Rank> list;

    final OnItemClickListener onItemClickListener;

    RankSliverList({ this.list, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return SliverList(
            delegate: (list != null && list.length > 0)
            ?   SliverChildBuilderDelegate(
                    (context, index) {
                        return RankSliverChild(
                            rank: list[index],
                            onItemClickListener: onItemClickListener,
                        );
                    },
                    childCount: list.length,
                )
            :   SliverChildListDelegate(
                    [
                        Padding(
                            padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
                            child: Center(
                                child: Text("목록 없음")
                            ),
                        ),
                    ],
                )
        );
    }

}

class RankSliverChild extends StatelessWidget {

    final Rank rank;

    final OnItemClickListener onItemClickListener;

    RankSliverChild({ this.rank, this.onItemClickListener });

    @override
    Widget build(BuildContext context) {
        return Material(
            color: Colors.transparent,
            child: InkWell(
                onTap: () {
                    if (onItemClickListener != null) {
                        onItemClickListener.onItemClick(this.rank);
                    }
                },
                child: Padding(
                    padding: EdgeInsets.all(12),
                    child: Row(
                        children: [
                            SizedBox(
                                width: 50,
                                child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                        rank.rankString,
                                        style: TextStyle(
                                            fontSize: 14,
                                        ),
                                    ),
                                ),
                            ),
                            Expanded(
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                        rank.subject,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
                                        style: TextStyle(
                                            fontSize: 14,
                                        ),
                                    ),
                                ),
                            ),
                            SizedBox(
                                width: 50,
                                child: Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                        rank.diffString,
                                        style: TextStyle(
                                            fontSize: 14,
                                        ),
                                    ),
                                ),
                            ),
                        ],
                    ),
                ),
            ),
        );
    }

}
