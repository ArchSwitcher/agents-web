import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';

class LoadingAutocompleteDropdown extends StatelessWidget {
  final RxBool isLoading;
  final List<DropDownOption> listItems;
  final Function(DropDownOption) onSelected;
  final String label;
  final String hintText;
  final Rx<DropDownOption> resetValue;
  final double width;
  final Future<List<DropDownOption>> Function(String) onTextChange;
  final bool enabled;
  final IconData prefixIcon;
  final String loadingText;
  final DropDownOption? initialValue;

  const LoadingAutocompleteDropdown({
    super.key,
    required this.isLoading,
    required this.listItems,
    required this.onSelected,
    required this.label,
    required this.hintText,
    required this.resetValue,
    required this.width,
    required this.enabled,
    required this.onTextChange,
    this.prefixIcon = Icons.person_outline,
    this.loadingText = '',
    this.initialValue

  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (isLoading.value) {
        return SizedBox(
          width: width,
          child:  Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(loadingText, style: CustomStyle.hintTextStyleBlack(context),),
                const Loading(),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        width: width,
        child: AutocompleteDropdownWidget(
          initialValue: initialValue,
          prefixIcon: prefixIcon,
          enabled: enabled,
          listItems: listItems,
          onSelected: onSelected,
          label: label,
          hintText: hintText,
          onFocusChange: (hasFocus) {},
          resetClean: (clean) {
            resetValue.value = DropDownOption(
              id: '',
              label: hintText,
            );
          },
          onTextChange: onTextChange,
        ),
      );
    });
  }
}