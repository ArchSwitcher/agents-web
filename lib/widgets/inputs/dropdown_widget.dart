import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';

class LoadingAutocompleteDropdown extends StatefulWidget {
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
  final String? Function(DropDownOption?)? validator;

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
    this.initialValue,
    this.validator,
  });

  @override
  State<LoadingAutocompleteDropdown> createState() => _LoadingAutocompleteDropdownState();
}

class _LoadingAutocompleteDropdownState extends State<LoadingAutocompleteDropdown> {
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (widget.isLoading.value) {
        return SizedBox(
          width: widget.width,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.loadingText,
                  style: CustomStyle.hintTextStyleBlack(context),
                ),
                const Loading(),
              ],
            ),
          ),
        );
      }
      return SizedBox(
        width: widget.width,
        child: AutocompleteDropdownWidget(
          validator: widget.validator,
          initialValue: widget.initialValue,
          prefixIcon: widget.prefixIcon,
          enabled: widget.enabled,
          listItems: widget.listItems,
          onSelected: widget.onSelected,
          label: widget.label,
          hintText: widget.hintText,
          onFocusChange: (hasFocus) {},
          resetClean: (clean) {
            widget.resetValue.value = DropDownOption(
              id: '',
              label: widget.hintText,
            );
          },
          onTextChange: widget.onTextChange,
        ),
      );
    });
  }
}
