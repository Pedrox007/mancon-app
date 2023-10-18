import 'package:flutter/material.dart';
import 'package:mancon_app/utils/format_to_money.dart';
import 'package:mancon_app/widgets/logo.dart';
import 'package:mancon_app/widgets/skeleton_loading_text.dart';
import 'package:skeleton_text/skeleton_text.dart';

class PersonalSliverHeaderDelegate extends SliverPersistentHeaderDelegate {
  final double _maxExtent = 200;
  final double _minLogoSize = 40;
  final double _maxLogoSize = 60;
  final double _minAmmountSize = 15;
  final double _maxAmmountSize = 30;
  final double _minLabelSize = 10;
  final double _maxLabelSize = 20;

  double totalAmmount;
  bool loading;

  PersonalSliverHeaderDelegate(
      {required this.totalAmmount, this.loading = false});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    double percent = -(((shrinkOffset * 100) / _maxExtent) - 100);
    return Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.background,
          borderRadius: const BorderRadius.only(
            bottomRight: Radius.circular(20),
            bottomLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(right: 70, top: 20 * percent / 100),
                    child: Align(
                        alignment: Alignment(
                          -(shrinkOffset > _maxExtent - 20
                                  ? _maxExtent - 20
                                  : shrinkOffset) /
                              _maxExtent,
                          0,
                        ),
                        child: Logo(
                          size: _minLogoSize > (_maxLogoSize * percent / 100)
                              ? _minLogoSize
                              : (_maxLogoSize * percent / 100),
                        )),
                  ),
                  Padding(
                      padding: EdgeInsets.only(
                          left: (30 * percent / 100) + 40,
                          top: (30 * percent / 100) + 10),
                      child: Align(
                        alignment: Alignment(
                          -(shrinkOffset > _maxExtent - 20
                                  ? _maxExtent - 20
                                  : shrinkOffset) /
                              _maxExtent,
                          0,
                        ),
                        child: AnimatedOpacity(
                          duration: const Duration(milliseconds: 100),
                          opacity: percent / 100,
                          child: const Text(
                            "MANCON",
                            style: TextStyle(
                                fontFamily: "Righteous", fontSize: 15),
                          ),
                        ),
                      )),
                  Padding(
                    padding: EdgeInsets.only(top: 105 * percent / 100),
                    child: Align(
                      alignment: Alignment(
                        (shrinkOffset > _maxExtent - 20
                                ? _maxExtent - 20
                                : shrinkOffset) /
                            _maxExtent,
                        0,
                      ),
                      child: Text(
                        "Total gasto",
                        style: TextStyle(
                          fontFamily: "inter",
                          fontSize:
                              _minLabelSize > (_maxLabelSize * percent / 100)
                                  ? _minLabelSize
                                  : (_maxLabelSize * percent / 100),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: (115 * percent / 100) + 20),
                      child: Align(
                        alignment: Alignment(
                            (shrinkOffset > _maxExtent - 20
                                    ? _maxExtent - 20
                                    : shrinkOffset) /
                                _maxExtent,
                            0),
                        child: loading
                            ? const SkeletonLoadingText(width: 160, height: 35)
                            : Text(
                                "R\$ ${formatToMoney(totalAmmount)}",
                                style: TextStyle(
                                  fontFamily: "Inter",
                                  fontSize: _minAmmountSize >
                                          (_maxAmmountSize * percent / 100)
                                      ? _minAmmountSize
                                      : (_maxAmmountSize * percent / 100),
                                ),
                              ),
                      ))
                ],
              )
            ],
          ),
        ));
  }

  @override
  double get maxExtent => _maxExtent;

  @override
  double get minExtent => kToolbarHeight;

  @override
  bool shouldRebuild(covariant PersonalSliverHeaderDelegate oldDelegate) {
    return oldDelegate != this;
  }
}
