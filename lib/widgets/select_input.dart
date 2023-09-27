import 'package:flutter/material.dart';

class SelectInput extends StatefulWidget {
  final List<DropdownMenuEntry<int>> options;
  int? selection;
  String label;

  SelectInput(
      {super.key,
      required this.options,
      required this.selection,
      required this.label});

  @override
  State<SelectInput> createState() => _SelectInputState();
}

class _SelectInputState extends State<SelectInput> {
  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
        textStyle: const TextStyle(fontSize: 16, fontFamily: "Inter"),
        menuStyle: MenuStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
              Theme.of(context).colorScheme.background),
        ),
        inputDecorationTheme: InputDecorationTheme(
            filled: true,
            labelStyle: const TextStyle(
              fontSize: 15,
              color: Colors.white,
              fontFamily: "Inter",
            ),
            fillColor: Theme.of(context).colorScheme.background,
            enabledBorder: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                borderSide: BorderSide(style: BorderStyle.none))),
        width: MediaQuery.of(context).size.width - 20,
        label: Text(widget.label),
        initialSelection: widget.selection,
        onSelected: (int? value) => widget.selection = value,
        dropdownMenuEntries: widget.options);
  }
}
