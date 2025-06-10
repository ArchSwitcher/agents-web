import 'package:flutter/material.dart';

class ContentCard extends StatelessWidget {
  final Widget child;

  const ContentCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Center(
      child: FractionallySizedBox(
        widthFactor: 0.95,
        child: Container(
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              // Sombra ligera alrededor
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(0.04),
                spreadRadius: 1,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
              // Sombra más marcada abajo
              BoxShadow(
                color: colorScheme.onSurface.withOpacity(0.08),
                spreadRadius: 1,
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: child,
          ),
        ),
      ),
    );
  }
}
