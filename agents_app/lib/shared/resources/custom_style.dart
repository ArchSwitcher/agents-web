import 'package:agents_app/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomStyle {
  static var textStyle = const TextStyle(fontSize: Dimensions.defaultTextSize);

  static var hintTextStyle = TextStyle(
      color: Colors.grey.withOpacity(0.5),
      fontSize: Dimensions.defaultTextSize);

  static var listStyle =
      const TextStyle(color: Colors.white, fontSize: Dimensions.defaultTextSize);

  static var defaultStyle =
      const TextStyle(color: Colors.black, fontSize: Dimensions.largeTextSize);

  static var focusBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 2.0),
  );

  static var focusErrorBorder = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );

  static var searchBox = OutlineInputBorder(
    borderRadius: const BorderRadius.all(Radius.circular(10.0)),
    borderSide: BorderSide(color: Colors.black.withOpacity(0.1), width: 1.0),
  );

  static var tableHeader = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 17,
    color: Colors.white,
    overflow: TextOverflow.ellipsis,
  );
}
