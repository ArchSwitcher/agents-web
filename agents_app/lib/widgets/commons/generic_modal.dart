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
    return AlertDialog(
      title: Text(title),
      content: content,
      actions: [
        TextButton(
          onPressed: () {
            onCancel?.call();
            Navigator.of(context).pop();
          },
          child: Text(cancelText),
        ),
        ElevatedButton(
          onPressed: () {
            onAccept?.call();
            Navigator.of(context).pop();
          },
          child: Text(acceptText),
        ),
      ],
    );
  }
}
