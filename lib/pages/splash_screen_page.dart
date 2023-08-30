import 'package:flutter/material.dart';
import 'package:mancon_app/widgets/splash_screen_widget.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  double imageSize = 150;
  double textOpacity = 0;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      setState(() {
        imageSize += 30;
      });

      await Future.delayed(const Duration(seconds: 3), () {
        setState(() {
          textOpacity = 1;
        });
      });

      await Future.delayed(const Duration(seconds: 2), () {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (route) => false);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SplashScreenWidget(
        imageSize: imageSize,
        textOpacity: textOpacity,
      ),
    );
  }
}
