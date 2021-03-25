import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

    final Widget title;
    final Widget backdrop;
    final Widget body;

    CustomAppBar({ this.title, this.backdrop, this.body });

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
                SliverAppBar(
                    iconTheme: IconThemeData(
                        color: Colors.grey,
                        opacity: 0.9,
                    ),
                    
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: MediaQuery.of(context).size.height * 0.35,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: [
                            StretchMode.zoomBackground,
                            StretchMode.blurBackground,
                        ],
                        titlePadding: EdgeInsetsDirectional.zero,
                        title: Container(
                            width: double.infinity,
                            child: Padding(
                                padding: EdgeInsets.all(16),
                                child: Center(
                                    heightFactor: 1,
                                    child: title,
                                ),
                            ),
                        ),
                        background: Stack(
                            fit: StackFit.expand,
                            children: [
                                Padding(
                                    padding: EdgeInsets.only(bottom: 5),
                                    child: backdrop,
                                ),
                                DecoratedBox(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.center,
                                            colors: [
                                                Colors.black,
                                                Colors.transparent
                                            ]
                                        ),
                                    ),
                                ),
                            ],
                        ),
                    ),
                ),
                body
            ],
        );
    }

}