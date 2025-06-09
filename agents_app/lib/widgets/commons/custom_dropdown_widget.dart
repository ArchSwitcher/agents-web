//import 'package:developer_company/shared/resources/colors.dart';
//import 'package:developer_company/shared/resources/custom_style.dart';
//import 'package:developer_company/shared/resources/dimensions.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatelessWidget {
  final String labelText;
  final String hintText;
  final String selectedValue;
  final List<DropdownMenuItem<String>> items;
  final String? Function(String?)? validator;
  final Icon prefixIcon;
  final ValueChanged<String?> onValueChanged;

  // final T selectedValue;

  CustomDropdownWidget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.selectedValue,
    required this.items,
    required this.validator,
    required this.prefixIcon,
    // required this.selectedValue,
    required this.onValueChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: Dimensions.heightSize * 0.5,
        ),
        DropdownButtonFormField<String>(
          style: CustomStyle.textStyle(context),
          onChanged: (value) {
            onValueChanged(value);
          },
          value: selectedValue,
          items: items,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            labelStyle: CustomStyle.textStyle(context),
            filled: true,
            fillColor: colorScheme.primary,
            hintStyle: CustomStyle.textStyle(context),
            focusedBorder: CustomStyle.focusBorder(context),
            enabledBorder: CustomStyle.focusErrorBorder(context),
            focusedErrorBorder: CustomStyle.focusErrorBorder(context),
            errorBorder: CustomStyle.focusErrorBorder(context),
            prefixIcon: const Icon(Icons.person_outline),
          ),
        ),
        const SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }
}
