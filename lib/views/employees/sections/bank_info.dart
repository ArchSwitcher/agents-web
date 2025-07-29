import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget bankInfoWidget(
    BuildContext context, EmployeeAgentController controller, bool enabled) {
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
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.bankController.value,
            prefixIcon: Icons.account_balance,
            validator: (value) =>
                notEmptyDropdownOption(value, "Banco requerido"),
            isLoading: controller.genericListController.isLoadingBank,
            listItems: controller.genericListController.bank,
            onSelected: (DropDownOption option) {
              controller.bankController.value = option;
            },
            label: "Nombre del Banco",
            hintText: "",
            resetValue: controller.bankController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.bank
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  enabled: enabled,
                  labelText: "Tipo de cuenta",
                  hintText: "",
                  items: accTypeBankMock,
                  validator: (p0) =>
                      notEmptyDropdownOption(p0, "Tipo de cuenta requerido"),
                  prefixIcon: const Icon(Icons.savings),
                  textEditingController: controller.accTypeBankController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.accTypeBankController.text =
                            v!.label.toString()
                        : null;
                  })),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.accNumberBankController,
              label: "Numero de cuenta",
              hintText: "",
              prefixIcon: Icons.account_balance_wallet,
            ),
          ),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  enabled: enabled,
                  labelText: "Forma de pago",
                  hintText: "",
                  items: paymentMethodMock,
                  validator: (p0) =>
                      notEmptyDropdownOption(p0, "Forma de pago requerida"),
                    prefixIcon: const Icon(Icons.payment),
                  textEditingController: controller.paymentMethodController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.paymentMethodController.text =
                            v!.label.toString()
                        : null;
                  }))
        ],
      );
    }),
  );
}
