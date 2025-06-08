import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Widget child;

  const ContentCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.95,
        heightFactor: 0.95,
        child: Card(
          color: colorScheme.surface,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          shadowColor: colorScheme.shadow.withOpacity(0.2),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
