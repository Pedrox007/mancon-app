import 'package:flutter/material.dart';
import 'package:skeleton_text/skeleton_text.dart';

class SkeletonLoadingText extends StatelessWidget {
  final double width;
  final double height;

  const SkeletonLoadingText({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SkeletonAnimation(
      borderRadius: BorderRadius.circular(10.0),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(-0.7, -0.8),
            stops: const [0.0, 0.5, 0.5, 1],
            colors: [
              Colors.white,
              Colors.white,
              Theme.of(context).colorScheme.background,
              Theme.of(context).colorScheme.background,
            ],
            tileMode: TileMode.repeated,
          ),
        ),
      ),
    );
  }
}
