import 'package:flutter/material.dart';
import 'package:mancon_app/widgets/button.dart';

class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback cancelAction;
  final VoidCallback confirmAction;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.cancelAction,
    required this.confirmAction,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.dangerous,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(title),
        ],
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 8),
        child: Text(message),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
          child: Button(
            label: "Confirmar",
            onPressed: confirmAction,
            buttonColor: Theme.of(context).colorScheme.error,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
          child: Button(
            label: "Cancelar",
            onPressed: cancelAction,
            secondary: true,
          ),
        )
      ],
    );
  }
}
