import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/logo.dart';
import 'package:mancon_app/widgets/skeleton_loading_text.dart';

class PersonalSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _minLogoSize = 40;
  final double _maxLogoSize = 60;
  final double _minAmmountSize = 15;
  final double _maxAmmountSize = 30;
  final double _minLabelSize = 10;
  final double _maxLabelSize = 20;

  double totalAmmount;
  bool loading;

  final LayerLink logoLayerLink = LayerLink();
  final LayerLink totalLayerLink = LayerLink();

  PersonalSliverHeaderDelegate(
      {required this.totalAmmount, this.loading = false});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double t = shrinkOffset / maxExtent;

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        borderRadius: const BorderRadius.only(
          bottomRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.lerp(
                      Alignment.topCenter, Alignment.centerLeft, t)!,
                  child: CompositedTransformTarget(
                    link: logoLayerLink,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Logo(
                        size: lerpDouble(_maxLogoSize, _minLogoSize, t)!,
                      ),
                    ),
                  ),
                ),
                CompositedTransformFollower(
                  link: logoLayerLink,
                  targetAnchor: Alignment.lerp(
                      Alignment.bottomCenter, Alignment.centerRight, t)!,
                  followerAnchor: Alignment.lerp(
                      Alignment.topCenter, Alignment.centerLeft, t)!,
                  child: const Text(
                    "MANCON",
                    style: TextStyle(
                      fontFamily: "Righteous",
                      fontSize: 15,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                    Alignment.center,
                    Alignment.topRight,
                    t,
                  )!,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: lerpDouble(105, 10, t)!,
                      right: lerpDouble(0, 15, t)!,
                    ),
                    child: Text(
                      "Total gasto",
                      style: TextStyle(
                        fontFamily: "inter",
                        fontSize: lerpDouble(_maxLabelSize, _minLabelSize, t)!,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.lerp(
                    Alignment.center,
                    Alignment.topRight,
                    t,
                  )!,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: lerpDouble(130, 25, t)!,
                      right: lerpDouble(0, 15, t)!,
                      bottom: 20,
                    ),
                    child: loading
                        ? const SkeletonLoadingText(width: 160, height: 35)
                        : Text(
                            formatToMoney(totalAmmount),
                            style: TextStyle(
                              fontFamily: "Inter",
                              fontSize: lerpDouble(
                                _maxAmmountSize,
                                _minAmmountSize,
                                t,
                              )!,
                            ),
                          ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  double get maxExtent => kToolbarHeight * 3.8;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant PersonalSliverHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
