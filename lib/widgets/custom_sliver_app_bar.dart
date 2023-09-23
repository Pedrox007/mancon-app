import 'package:flutter/material.dart';
import 'package:mancon_app/widgets/logo.dart';

class CustomSliverAppBar extends StatefulWidget {
  const CustomSliverAppBar({super.key});

  @override
  State<CustomSliverAppBar> createState() => _CustomSliverAppBarState();
}

class _CustomSliverAppBarState extends State<CustomSliverAppBar> {
  final controller = ScrollController();
  double appBarHeight = 200.0;
  double logoMinSize = 40;

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: appBarHeight,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double percent = ((constraints.maxHeight - kToolbarHeight) *
              100 /
              (appBarHeight - kToolbarHeight));
          debugPrint(percent.toString());
          return Align(
            alignment: Alignment(0, 0),
            child: Row(
              children: [
                Logo(
                  size: logoMinSize > 50 * percent / 100
                      ? logoMinSize
                      : 50 * percent / 100,
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
