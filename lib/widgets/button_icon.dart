import 'package:flutter/material.dart';

class ButtonIcon extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final IconData? icon;
  final Color? buttonColor;
  final Color? labelColor;
  final bool secondary;

  const ButtonIcon(
      {super.key,
      required this.label,
      required this.onPressed,
      this.width,
      this.height,
      this.icon,
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
              side: secondary
                  ? BorderSide(color: Theme.of(context).colorScheme.secondary)
                  : BorderSide.none,
            ),
            backgroundColor: secondary
                ? Theme.of(context).colorScheme.secondary
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
                  color: secondary
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 10),
              Icon(
                icon,
                color: secondary
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.secondary,
                size: 23,
              ),
            ],
          )),
    );
  }
}
