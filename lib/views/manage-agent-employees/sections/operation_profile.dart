import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/email_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget rrhhProfile(
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
            initialValue: controller.hrProfileController.value,
            prefixIcon: Icons.work,
            validator: (value) =>
                notEmptyDropdownOption(value, "Nivel de clasificación"),
            isLoading: controller.genericListController.isLoadingHrProfile,
            listItems: controller.genericListController.hrProfile,
            onSelected: (DropDownOption option) {
              controller.hrProfileController.value = option;
            },
            label: "Nivel de clasificación",
            hintText: "",
            resetValue: controller.hrProfileController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.hrProfile
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          // 11111111111111111111111111 --------------------------------------
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.classificationLevelController.value,
            prefixIcon: Icons.work,
            validator: (value) => notEmptyDropdownOption(
                value, "Clasificación del puesto requerida"),
            isLoading: controller
                .genericListController.isLoadingEmployeeClassification,
            listItems: controller.genericListController.employeeClassifications,
            onSelected: (DropDownOption option) {
              controller.classificationController.value = option;
            },
            label: "Clasificación del puesto",
            hintText: "",
            resetValue: controller.classificationController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.employeeClassifications
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          SizedBox(
            width: width,
            child: CustomLabelWidget(
                title: "Estado del trabajador",
                label: "ACTIVO",
                prefixIcon: Icons.check_circle_outline),
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.supervisorController.value,
            prefixIcon: Icons.work,
            validator: (value) =>
                notEmptyDropdownOption(value, "Jefe inmediato requerido"),
            isLoading: controller.isLoadingSupervisor,
            listItems: controller.supervisors,
            onSelected: (DropDownOption option) {
              controller.supervisorController.value = option;
            },
            label: "Jefe inmediato",
            hintText: "",
            resetValue: controller.supervisorController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller.supervisors
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.performanceDepartmentController.value,
            prefixIcon: Icons.location_city,
            validator: (value) => notEmptyDropdownOption(
                value, "Departamento de desempeño requerido"),
            isLoading: controller.isLoadingPerformanceDepartments,
            listItems: controller.performanceDepartments,
            onSelected: (DropDownOption option) async {
              controller.performanceDepartmentController.value = option;
              controller.isLoadingPerformanceMunicipalities.value = true;
              controller.performanceMunicipalities.value = await controller
                  .genericListController
                  .fetchMunicipalitiesOnly(option.id);
              controller.isLoadingPerformanceMunicipalities.value = false;
            },
            label: "Departamento de desempeño",
            hintText: "",
            resetValue: controller.performanceDepartmentController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .performanceDepartments
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.performanceMunicipalityController.value,
            prefixIcon: Icons.location_city,
            validator: (value) => notEmptyDropdownOption(
                value, "Municipio de desempeño requerido"),
            isLoading: controller.isLoadingPerformanceMunicipalities,
            listItems: controller.performanceMunicipalities,
            onSelected: (DropDownOption option) async {
              controller.performanceMunicipalityController.value = option;
            },
            label: "Municipio de desempeño",
            hintText: "",
            resetValue: controller.performanceMunicipalityController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .performanceMunicipalities
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
              controller: controller.mintrabPerformanceRegionController,
              label: "Región MINTRAB Desempeño",
              hintText: "",
              prefixIcon: Icons.location_on,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.mintrabBirthRegionController,
              label: "Region nacimiento MINTRAB",
              hintText: "",
              prefixIcon: Icons.location_on,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.positionMtController,
              label: "Puesto según MT",
              hintText: "",
              prefixIcon: Icons.work,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.digesspPositionController,
              label: "Puesto DIGESSP",
              hintText: "",
              prefixIcon: Icons.work,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.positionSlotController,
              label: "Proseña",
              hintText: "",
              prefixIcon: Icons.work,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.companyEmailController,
              label: "Email de la empresa",
              hintText: "",
              prefixIcon: Icons.email,
              validator: (value) => emailValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.igssController,
              label: "IGSS",
              hintText: "",
              prefixIcon: Icons.numbers,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.cvhController,
              label: "CVH",
              hintText: "",
              prefixIcon: Icons.credit_score_sharp,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(width: width),
          SizedBox(width: width)
        ],
      );
    }),
  );
}
