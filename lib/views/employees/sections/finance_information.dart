import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget financialMITInformation(
    BuildContext context, EmployeeController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 750;
      final width = isWideScreen
          ? (constraints.maxWidth / 4) - 40
          : constraints.maxWidth - 40;

      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width,
            child: AutocompleteDropdownWidget(
              listItems: banksMock,
              label: "Banco",
              hintText: "",
              prefixIcon: Icons.account_balance,
              initialValue: controller.bankController.value,
              onSelected: (selected) {
                controller.bankController.value = selected;
              },
              onFocusChange: (hasFocus) {},
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = banksMock
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty ? [] : filteredOptions;
              },
            ),
          ),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.accountNumberController,
                  label: "Número de Cuenta",
                  hintText: "",
                  prefixIcon: Icons.credit_card)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.mtPositionController,
                  label: "Posición MT",
                  hintText: "",
                  prefixIcon: Icons.work_outline)),
        ],
      );
    }),
  );
}
