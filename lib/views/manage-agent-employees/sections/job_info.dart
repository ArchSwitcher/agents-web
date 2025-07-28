import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget jobInformation(
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
            initialValue: controller.agencyController.value,
            prefixIcon: Icons.business,
            validator: (value) =>
                notEmptyDropdownOption(value, "Agencia del Ebano Requerida"),
            isLoading: controller.genericListController.isLoadingAgency,
            listItems: controller.genericListController.agencies,
            onSelected: (DropDownOption option) {
              controller.agencyController.value = option;
            },
            label: "Agencia el Ebano",
            hintText: "Agencia el Ebano",
            resetValue: controller.agencyController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.agencies
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.agencyController.value,
            prefixIcon: Icons.work,
            validator: (value) =>
                notEmptyDropdownOption(value, "Cargo Requerido"),
            isLoading: controller.genericListController.isLoadingEmployeeType,
            listItems: controller.genericListController.employeeType,
            onSelected: (DropDownOption option) {
              controller.employeeTypeController.value = option;
            },
            label: "Cargo del Empleado",
            hintText: "Puesto de trabajo",
            resetValue: controller.agencyController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.employeeType
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
                  labelText: "Tipo de contrato",
                  hintText: "",
                  items: contractTypeMock,
                  validator: (p0) =>
                      notEmptyDropdownOption(p0, "Tipo de contrato requerido"),
                  prefixIcon: const Icon(Icons.assignment),
                  textEditingController: controller.contractTypeController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.contractTypeController.text =
                            v!.label.toString()
                        : null;
                  })),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  enabled: enabled,
                  labelText: "Tipo de contratación",
                  hintText: "",
                  items: contractTypeTermMock,
                  validator: (p0) => notEmptyDropdownOption(
                      p0, "Tipo de contratación requerido"),
                  prefixIcon: const Icon(Icons.assignment_ind),
                  textEditingController: controller.contractTypeTermController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.contractTypeTermController.text =
                            v!.label.toString()
                        : null;
                  })),

          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.contractTimeController,
                enabled: enabled,
                label: "Tiempo de contrato",
                hintText: "Tiempo de contrato",
                prefixIcon: Icons.timer),
          ),

          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.startDateController,
                enabled: enabled,
                label: "Fecha de ingreso",
                hintText: "",
                prefixIcon: Icons.date_range),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.entryReasonController,
              label: "Causa de Ingreso",
              hintText: "",
              prefixIcon: Icons.input,
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.workScheduleController,
              label: "Jornada de trabajo",
              hintText: "",
              prefixIcon: Icons.input,
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.costCenterController,
              label: "Centro de costo",
              hintText: "",
              prefixIcon: Icons.input,
            ),
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.maritalStatusController.value,
            prefixIcon: Icons.family_restroom,
            validator: (value) =>
                notEmptyDropdownOption(value, "Estado civil requerido"),
            isLoading: controller.genericListController.isLoadingMaritalStatus,
            listItems: controller.genericListController.maritalStatus,
            onSelected: (DropDownOption option) {
              controller.maritalStatusController.value = option;
            },
            label: "Estado civil",
            hintText: "",
            resetValue: controller.maritalStatusController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.maritalStatus
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          // SizedBox(
          //   width: width,
          //   child: Obx(() => CustomCheckboxLabelWidget(
          //         icon: Icons.flag,
          //         label: "¿Es extranjero?",
          //         isChecked: controller.nationalityController.value,
          //         onChanged: (value) => enabled
          //             ? controller.nationalityController.value =
          //                 value ?? false
          //             : null,
          //       ))),
          //  SizedBox(
          //     width: width,
          //     child: CustomDropdownV2Widget(
          //         labelText: "Idioma",
          //         hintText: "",
          //         items: languageMock.map<DropDownOption>((String value) {
          //           return DropDownOption(
          //             id: value,
          //             label: value,
          //           );
          //         }).toList(),
          //         validator: (p0) => null,
          //         prefixIcon: const Icon(Icons.language),
          //         textEditingController: controller.languageController,
          //         onValueChanged: (v) {
          //           enabled
          //               ? controller.languageController.text =
          //                   v!.label.toString()
          //               : null;
          //         })),
//  SizedBox(
//             width: width,
//             child: CustomInputWidget(
//               controller: controller.addressController,
//               label: "Dirección",
//               hintText: "",
//               prefixIcon: Icons.location_on,
//             ),
//           ),
        ],
      );
    }),
  );
}
