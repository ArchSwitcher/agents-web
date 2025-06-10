import 'package:flutter/material.dart';

class GenericModal extends StatelessWidget {
  final Widget content;
  final VoidCallback? onAccept;
  final VoidCallback? onCancel;
  final String title;
  final String acceptText;
  final String cancelText;

  const GenericModal({
    super.key,
    required this.content,
    this.onAccept,
    this.onCancel,
    this.title = 'Confirmación',
    this.acceptText = 'Aceptar',
    this.cancelText = 'Cancelar',
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return AlertDialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.onError,
            foregroundColor: colorScheme.surface
          ),
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          style: TextButton.styleFrom(
            backgroundColor: colorScheme.primaryFixed,
            foregroundColor: colorScheme.surface
          ),
          onPressed: () {
            onAccept?.call();
            //Navigator.of(context).pop();
          },
          child: Text(acceptText),
        ),
      ],
    );
  }
}
