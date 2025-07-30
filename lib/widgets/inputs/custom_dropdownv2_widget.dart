import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/shared/resources/dimensions.dart';
import 'package:flutter/material.dart';

class CustomDropdownV2Widget extends StatefulWidget {
  final String labelText;
  final String hintText;
  final List<DropDownOption> items;
  final String? Function(DropDownOption?)? validator;
  final Icon prefixIcon;
  final TextEditingController textEditingController;
  final ValueChanged<DropDownOption?> onValueChanged;
  final DropDownOption? initialValue;
  final bool? enabled;

  CustomDropdownV2Widget({
    Key? key,
    required this.labelText,
    required this.hintText,
    required this.items,
    required this.validator,
    required this.prefixIcon,
    required this.textEditingController,
    required this.onValueChanged,
    this.initialValue,
    this.enabled = true,
  }) : super(key: key);

  @override
  State<CustomDropdownV2Widget> createState() => _CustomDropdownV2WidgetState();
}

class _CustomDropdownV2WidgetState extends State<CustomDropdownV2Widget> {
  DropDownOption? _selectedValue; // Internal selected value

  @override
  void initState() {
    super.initState();
    _selectedValue = widget.initialValue;
    if (_selectedValue != null || widget.textEditingController.text.isNotEmpty) {
      print("Initial value: ${widget.initialValue?.label}");
      // widget.textEditingController.text = _selectedValue!.id;
      _selectedValue = widget.items.firstWhere(
        (item) => item.id == widget.textEditingController.text,
        orElse: () => DropDownOption(id: "", label: ""),
      );
    }
  }

  @override
  void didUpdateWidget(covariant CustomDropdownV2Widget oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget called ${widget.initialValue?.label}");
    final matchingItem = widget.items.firstWhere(
      (item) => item.id == widget.textEditingController.text,
      orElse: () => DropDownOption(id: "", label: ""),
    );
    print("Matching item: ${widget.labelText} ${matchingItem.label} ------- ${_selectedValue?.id != matchingItem.id} ${_selectedValue?.id} ${matchingItem.id}");

    if ((_selectedValue?.id != matchingItem.id) && matchingItem.id.isNotEmpty) {
      setState(() {
        _selectedValue = matchingItem;
      });
    }else {
      setState(() {
        _selectedValue = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.labelText,
          style: const TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: Dimensions.heightSize * 0.5,
        ),
        DropdownButtonFormField<DropDownOption>(
          style: CustomStyle.textStyleBlack(context),
          onChanged: (value) {
            setState(() {
              _selectedValue = value;
            });
            widget.onValueChanged(value);
            widget.textEditingController.text = value?.id ?? '';
          },
          value: _selectedValue,
          items: widget.items.map((DropDownOption option) {
            return DropdownMenuItem<DropDownOption>(
              value: option,
              child: Text(option.label),
            );
          }).toList(),
          validator: widget.validator,
          decoration: InputDecoration(
            hintText: widget.hintText,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            labelStyle: CustomStyle.textStyleBlack(context),
            filled: true,
            fillColor: colorScheme.surface,
            hintStyle: CustomStyle.textStyleBlack(context),
            focusedBorder: CustomStyle.focusBorder(context),
            enabledBorder: CustomStyle.focusErrorBorder(context),
            focusedErrorBorder: CustomStyle.focusErrorBorder(context),
            errorBorder: CustomStyle.focusErrorBorder(context),
            prefixIcon: widget.prefixIcon,
          ),
        ),
        const SizedBox(
          height: Dimensions.heightSize,
        ),
      ],
    );
  }
}
