import 'package:flutter/material.dart';
import 'package:agents_app/shared/resources/dimensions.dart';

class CustomStyle {
  static TextStyle layoutTitleText(BuildContext context) => TextStyle(
        fontSize: Dimensions.titleTextSize,
        color: Theme.of(context).colorScheme.onPrimary,
      );

  static TextStyle layoutDescriptionText(BuildContext context) => TextStyle(
        fontSize: Dimensions.descriptionTextSize,
        color: Theme.of(context).colorScheme.onPrimary.withAlpha(204),
        fontStyle: FontStyle.italic,
      );

  static TextStyle textStyle(BuildContext context) => TextStyle(
        fontSize: Dimensions.defaultTextSize,
        color: Theme.of(context).colorScheme.onSurface,
      );

  static TextStyle hintTextStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
        fontSize: Dimensions.defaultTextSize,
      );

  static TextStyle listStyle(BuildContext context) => const TextStyle(
        color: Colors.white,
        fontSize: Dimensions.defaultTextSize,
      );

  static TextStyle defaultStyle(BuildContext context) => TextStyle(
        color: Theme.of(context).colorScheme.primary,
        fontSize: Dimensions.largeTextSize,
      );

  static OutlineInputBorder focusBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
          width: 2.0,
        ),
      );

  static OutlineInputBorder focusErrorBorder(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.error.withOpacity(0.1),
          width: 1.0,
        ),
      );

  static OutlineInputBorder searchBox(BuildContext context) =>
      OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(10.0)),
        borderSide: BorderSide(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.1),
          width: 1.0,
        ),
      );

  static TextStyle tableHeader(BuildContext context) => TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 17,
        color: Theme.of(context).colorScheme.onPrimary,
        overflow: TextOverflow.ellipsis,
      );
}
