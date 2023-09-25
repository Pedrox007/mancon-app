import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Color? buttonColor;
  final Color? labelColor;
  final bool secondary;

  const Button(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.height,
      this.buttonColor,
      this.labelColor,
      this.secondary = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.width,
      height: height ?? 55,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide.none,
            ),
            backgroundColor: secondary
                ? Theme.of(context).colorScheme.background
                : Theme.of(context).colorScheme.primary,
            elevation: 2,
          ),
          child: Wrap(
            children: [
              Text(
                label.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              )
            ],
          )),
    );
  }
}
