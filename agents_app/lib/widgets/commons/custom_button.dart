import "package:agents_app/shared/resources/dimensions.dart";
import "package:flutter/material.dart";

class CustomButton extends StatelessWidget {
  final Color color;
  final String text;
  final bool isLoading;
  final VoidCallback onPress;
  const CustomButton(
      {super.key,
      required this.color,
      required this.text,
      required this.isLoading,
      required this.onPress});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: color),
        onPressed: isLoading ? null : onPress,
        child: isLoading
            ? SizedBox(
                height: Dimensions.largeTextSize,
                width: Dimensions.largeTextSize,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: colorScheme.onPrimary),
              )
            : Text(text, style: TextStyle(color: Colors.white)));
  }
}
