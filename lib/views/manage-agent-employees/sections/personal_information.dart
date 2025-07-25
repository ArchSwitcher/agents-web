import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_checkbox_label_widget.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget personalInformation(
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
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: enabled,
                  controller: controller.firstNameController,
                  label: "Primer nombre",
                  hintText: "",
                  prefixIcon: Icons.person)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: enabled,
                  controller: controller.middleNameController,
                  label: "Segundo Nombre",
                  hintText: "",
                  prefixIcon: Icons.person)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: enabled,
                  controller: controller.lastNameController,
                  label: "Apellido",
                  hintText: "",
                  prefixIcon: Icons.person)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  enabled: enabled,
                  controller: controller.secondLastNameController,
                  label: "Segundo Apellido",
                  hintText: "",
                  prefixIcon: Icons.person)),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  labelText: "Género",
                  hintText: "",
                  items: genderMock.map<DropDownOption>((String value) {
                    return DropDownOption(
                      id: value,
                      label: value,
                    );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.transgender),
                  textEditingController: controller.genderController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.genderController.text = v!.label.toString()
                        : null;
                  })),
          SizedBox(
              width: width,
              child: CustomDatePicker(
                  enabled: enabled,
                  firstDate: DateTime(1900),
                  validator: (value) {
                    // Validate the date input and verify if the ages is greater than 18
                    if (value == null) {
                      return "Fecha de nacimiento es requerida";
                    }
                    DateTime? birthDate;
                    try {
                      birthDate = DateTime.parse(value);
                    } catch (e) {
                      return "Fecha de nacimiento inválida";
                    }
                    final age =
                        DateTime.now().difference(birthDate).inDays ~/ 365;
                    if (age < 18) {
                      return "El empleado debe ser mayor de 18 años";
                    }
                    return null;
                  },
                  initialDate: DateTime.now(),
                  controller: controller.birthDateController,
                  label: "Fecha de nacimiento",
                  hintText: "",
                  prefixIcon: Icons.cake)),
          SizedBox(
            width: width,
            child: LoadingAutocompleteDropdown(
              enabled: enabled,
              initialValue: controller.identificationType.value,
              prefixIcon: Icons.badge,
              validator: (value) => notEmptyDropdownOption(
                  value, "Tipo de identificación requerido"),
              isLoading:
                  controller.genericListController.isLoadingIdentificationType,
              listItems: controller.genericListController.identificationType,
              onSelected: (DropDownOption option) {
                controller.identificationType.value = option;
              },
              label: "Tipo de identificación",
              hintText: "Identificación",
              resetValue: controller.identificationType,
              width: width,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.identificationType
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
                  enabled: enabled,
                  controller: controller.identificationController,
                  label: "Identificación",
                  hintText: "",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Identificación es requerida";
                    }
                    final regex = RegExp(r'^\d{13}$');
                    if (!regex.hasMatch(value)) {
                      return "La identificación debe tener exactamente 13 dígitos numéricos";
                    }
                    return null;
                  },
                  prefixIcon: Icons.credit_card)),
          SizedBox(
              width: width,
              child: Obx(() => CustomCheckboxLabelWidget(
                    icon: Icons.flag,
                    label: "¿Es extranjero?",
                    isChecked: controller.nationalityController.value,
                    onChanged: (value) => enabled
                        ? controller.nationalityController.value =
                            value ?? false
                        : null,
                  ))),
          SizedBox(
            width: width,
            child: LoadingAutocompleteDropdown(
              enabled: enabled,
              initialValue: controller.bloodTypeController.value,
              prefixIcon: Icons.bloodtype,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Tipo de sangre"),
              isLoading: controller.genericListController.isLoadingBloodType,
              listItems: controller.genericListController.bloodType,
              onSelected: (DropDownOption option) {
                controller.bloodTypeController.value = option;
              },
              label: "Tipo de sangre",
              hintText: "Sangre",
              resetValue: controller.bloodTypeController,
              width: width,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.bloodType
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty ? [] : filteredOptions;
              },
            ),
          ),
          SizedBox(
            width: width,
            child: LoadingAutocompleteDropdown(
              enabled: enabled,
              initialValue: controller.maritalStatusController.value,
              prefixIcon: Icons.family_restroom,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Estado civil"),
              isLoading:
                  controller.genericListController.isLoadingMaritalStatus,
              listItems: controller.genericListController.maritalStatus,
              onSelected: (DropDownOption option) {
                controller.maritalStatusController.value = option;
              },
              label: "Estado civil",
              hintText: "Estado civil",
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
          ),

          SizedBox(
            width: width,
            child: LoadingAutocompleteDropdown(
              enabled: enabled,
              initialValue: controller.educationController.value,
              prefixIcon: Icons.school,
              validator: (value) =>
                  notEmptyDropdownOption(value, "Grado académico"),
              isLoading:
                  controller.genericListController.isLoadingEducation,
              listItems: controller.genericListController.education,
              onSelected: (DropDownOption option) {
                controller.educationController.value = option;
              },
              label: "Grado académico",
              hintText: "grado académico",
              resetValue: controller.educationController,
              width: width,
              onTextChange: (text) async {
                List<DropDownOption> filteredOptions = controller
                    .genericListController.education
                    .where((option) =>
                        option.label.toLowerCase().contains(text.toLowerCase()))
                    .toList();
                return filteredOptions.isEmpty ? [] : filteredOptions;
              },
            ),
          ),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  labelText: "Idioma",
                  hintText: "",
                  items: languageMock.map<DropDownOption>((String value) {
                    return DropDownOption(
                      id: value,
                      label: value,
                    );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.language),
                  textEditingController: controller.languageController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.languageController.text =
                            v!.label.toString()
                        : null;
                  })),
          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  labelText: "Etnia",
                  hintText: "",
                  items: ethnicityMock.map<DropDownOption>((String value) {
                    return DropDownOption(
                      id: value,
                      label: value,
                    );
                  }).toList(),
                  validator: (p0) => null,
                  prefixIcon: const Icon(Icons.people),
                  textEditingController: controller.ethnicityController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.ethnicityController.text =
                            v!.label.toString()
                        : null;
                  })),
          SizedBox(width: width),
          SizedBox(width: width),
        ],
      );
    }),
  );
}
