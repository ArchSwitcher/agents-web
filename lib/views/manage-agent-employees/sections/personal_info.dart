import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_checkbox_label_widget.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget personalInfo(
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
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.middleNameController,
              label: "Segundo nombre",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.lastNameController,
              label: "Primer apellido",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.secondLastNameController,
              label: "segundo apellido",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.marriedLastNameController,
              label: "apellido de casada",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),

          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.birthDateController,
                enabled: enabled,
                label: "Fecha de nacimiento",
                hintText: "",
                prefixIcon: Icons.cake),
          ),

          SizedBox(
              width: width,
              child: CustomDropdownV2Widget(
                  labelText: "Genero",
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
              child: Obx(() => CustomCheckboxLabelWidget(
                    icon: Icons.flag,
                    label: "¿Es extranjero?",
                    isChecked: controller.nationalityController.value,
                    onChanged: (value) => enabled
                        ? controller.nationalityController.value =
                            value ?? false
                        : null,
                  ))),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.identificationTypeController.value,
            prefixIcon: Icons.badge,
            validator: (value) => notEmptyDropdownOption(
                value, "Tipo de identificación requerido"),
            isLoading:
                controller.genericListController.isLoadingIdentificationType,
            listItems: controller.genericListController.identificationType,
            onSelected: (DropDownOption option) {
              controller.identificationTypeController.value = option;
            },
            label: "Tipo de identificación",
            hintText: "",
            resetValue: controller.identificationTypeController,
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

          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.identificationController,
              label: "Numero de identificación",
              hintText: "",
              prefixIcon: Icons.badge,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),

          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.identificationIssueDateController,
                enabled: enabled,
                label: "Fecha de emisión de identificación",
                hintText: "",
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: Icons.badge),
          ),
          SizedBox(
            width: width,
            child: CustomDatePicker(
                initialDate: DateTime(2025),
                controller: controller.identificationEndDateController,
                enabled: enabled,
                label: "Fecha de vencimiento de identificación",
                validator: (value) => notEmptyFieldValidator(value),
                hintText: "",
                prefixIcon: Icons.badge),
          ),

          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.identificationController,
              label: "Numero de identificación",
              hintText: "",
              prefixIcon: Icons.badge,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.licenseTypeController.value,
            prefixIcon: Icons.card_membership,
            validator: (value) =>
                notEmptyDropdownOption(value, "Tipo de licencia requerida"),
            isLoading: controller.genericListController.isLoadingLicense,
            listItems: controller.genericListController.license,
            onSelected: (DropDownOption option) {
              controller.licenseTypeController.value = option;
            },
            label: "Tipo de licencia",
            hintText: "",
            resetValue: controller.licenseTypeController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.license
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.licenseController,
              label: "Numero de licencia",
              hintText: "",
              prefixIcon: Icons.badge,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.nitController,
              label: "NIT",
              hintText: "",
              prefixIcon: Icons.numbers,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.educationLevelController.value,
            prefixIcon: Icons.school,
            validator: (value) =>
                notEmptyDropdownOption(value, "Nivel de escolaridad requerido"),
            isLoading: controller.genericListController.isLoadingEducation,
            listItems: controller.genericListController.education,
            onSelected: (DropDownOption option) {
              controller.educationLevelController.value = option;
            },
            label: "Nivel de escolaridad",
            hintText: "",
            resetValue: controller.educationLevelController,
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

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.professionController.value,
            prefixIcon: Icons.school,
            validator: (value) =>
                notEmptyDropdownOption(value, "Profesión requerida"),
            isLoading: controller.genericListController.isLoadingProfessions,
            listItems: controller.genericListController.professions,
            onSelected: (DropDownOption option) {
              controller.professionController.value = option;
            },
            label: "Profesión",
            hintText: "",
            resetValue: controller.professionController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.professions
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
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
                  prefixIcon: const Icon(Icons.group),
                  textEditingController: controller.ethnicityController,
                  onValueChanged: (v) {
                    enabled
                        ? controller.ethnicityController.text =
                            v!.label.toString()
                        : null;
                  })),

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
        ],
      );
    }),
  );
}
