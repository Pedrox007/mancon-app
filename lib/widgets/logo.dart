import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double size;
  final VoidCallback? onPressed;

  const Logo({
    Key? key,
    this.size = 500,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: size,
        height: size,
        child: Image.asset("assets/images/logo.png"),
      ),
    );
  }
}
