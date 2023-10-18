import 'package:flutter/material.dart';
import 'package:mancon_app/widgets/logo.dart';

class SplashScreenWidget extends StatelessWidget {
  final double imageSize;
  final double textOpacity;
  final bool loading;

  const SplashScreenWidget({
    super.key,
    required this.imageSize,
    required this.textOpacity,
    required this.loading,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: const Duration(seconds: 3),
            height: imageSize,
            width: imageSize,
            curve: Curves.fastOutSlowIn,
            child: Logo(size: imageSize),
          ),
          const SizedBox(
            height: 20,
          ),
          AnimatedOpacity(
            opacity: textOpacity,
            duration: const Duration(seconds: 2),
            child: const Text(
              "MANCON",
              style: TextStyle(fontFamily: "Righteous", fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          if (loading) const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
