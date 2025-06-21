// import 'package:developer_company/shared/resources/colors.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  final Color activeColor;
  final Color unSelectedColor;
  final Color checkColor;
  final String text;

  const CustomCheckbox(
      {super.key,
      required this.value,
      required this.onChanged,
      required this.activeColor,
      required this.unSelectedColor,
      required this.checkColor,
      this.text = ""
      });

  @override
  CustomCheckboxState createState() => CustomCheckboxState();
}

class CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    // adding textbox in the right side of the checkbox
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 30,
            height: 30,
            child: Checkbox(
              value: widget.value,
              onChanged: widget.onChanged,
              activeColor: widget.activeColor,
              checkColor: widget.checkColor,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            widget.text,
            style: CustomStyle.defaultStyle(context),
          ),
        ],
      ),
    );
  }
}
