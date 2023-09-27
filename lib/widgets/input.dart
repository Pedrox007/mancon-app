import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Input extends StatelessWidget {
  final String label;
  final Icon? preffixIcon;
  final Icon? suffixIcon;
  final bool disabled;
  final TextEditingController? controller;
  final TextInputType type;
  final bool obscureText;
  final ValueNotifier<bool> _obscureTextVN;
  final List<TextInputFormatter>? inputFormatters;

  Input(
      {Key? key,
      required this.label,
      this.preffixIcon,
      this.suffixIcon,
      this.disabled = false,
      this.controller,
      required this.type,
      this.obscureText = false,
      this.inputFormatters})
      : _obscureTextVN = ValueNotifier<bool>(obscureText),
        assert(
          obscureText == true ? suffixIcon == null : true,
          'obscureText não pode ser adicionado junto com o suffixicon',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
        valueListenable: _obscureTextVN,
        builder: (_, obscureTextValue, child) {
          return TextField(
            inputFormatters: inputFormatters,
            obscureText: obscureTextValue,
            keyboardType: type,
            readOnly: disabled,
            controller: controller,
            style: TextStyle(
              fontSize: 16,
              color: disabled
                  ? Colors.white38
                  : Theme.of(context).colorScheme.secondary,
            ),
            decoration: InputDecoration(
              filled: true,
              labelText: label,
              labelStyle: const TextStyle(
                fontSize: 15,
                color: Colors.white,
                fontFamily: "Inter",
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  borderSide: BorderSide(style: BorderStyle.none)),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 5,
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary, width: 1.1),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 5,
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 1),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                gapPadding: 5,
                borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error, width: 1),
              ),
              prefixIcon: preffixIcon,
              suffixIcon: obscureText
                  ? IconButton(
                      onPressed: () {
                        _obscureTextVN.value = !obscureTextValue;
                      },
                      icon: Icon(
                        obscureTextValue
                            ? Icons.visibility
                            : Icons.visibility_off,
                        size: 16,
                      ),
                      color: Colors.white,
                    )
                  : suffixIcon,
            ),
          );
        });
  }
}
