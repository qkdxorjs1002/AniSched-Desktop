import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {

    final Widget title;
    final bool leading;
    final String backdrop;
    final Widget bottom;
    final Widget body;
    final bool collapsed;

    CustomAppBar({ this.title, this.leading = true, this.backdrop, this.bottom, this.body, this.collapsed = true });

    @override
    Widget build(BuildContext context) {
        return CustomScrollView(
            physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
            ),
            slivers: [
                SliverAppBar(
                    automaticallyImplyLeading: leading,
                    bottom: bottom != null ? bottom : null,
                    iconTheme: IconThemeData(
                        color: Colors.grey,
                        opacity: 0.9,
                    ),
                    elevation: 0,
                    pinned: true,
                    snap: true,
                    floating: true,
                    expandedHeight: collapsed ? 0 : MediaQuery.of(context).size.height * 0.35,
                    stretch: true,
                    flexibleSpace: FlexibleSpaceBar(
                        collapseMode: CollapseMode.parallax,
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
                                    child: backdrop != null && backdrop.isNotEmpty ? Image.network(
                                        backdrop,
                                        fit: BoxFit.cover,
                                    ) : null,
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