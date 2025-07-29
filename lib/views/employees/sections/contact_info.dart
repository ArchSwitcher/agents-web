import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget contactInfo(
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
                controller: controller.emailController,
                label: "Email personal",
                hintText: "",
                prefixIcon: Icons.email),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.mobileController,
              label: "Teléfono personal",
              hintText: "",
              prefixIcon: Icons.phone,
              keyboardType: TextInputType.phone,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.cityController,
              label: "Ciudad de domicilio",
              hintText: "",
              prefixIcon: Icons.location_city_sharp,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.addressController,
              label: "Dirección de domicilio",
              hintText: "",
              prefixIcon: Icons.location_city_sharp,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.departmentHomeController.value,
            prefixIcon: Icons.location_city_outlined,
            validator: (value) =>
                notEmptyDropdownOption(value, "departamento requerido"),
            isLoading: controller.isLoadingDepartmentHome,
            listItems: controller.departmentsHome,
            onSelected: (DropDownOption option) async {
              controller.departmentHomeController.value = option;
              controller.isLoadingMunicipalityHome.value = true;
              controller.municipalitiesHome.value = await controller
                  .genericListController
                  .fetchMunicipalities(option.id);
              controller.isLoadingMunicipalityHome.value = false;
            },
            label: "Departamento de domicilio",
            hintText: "",
            resetValue: controller.departmentHomeController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller.departmentsHome
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.municipalityHomeController.value,
            prefixIcon: Icons.location_city_rounded,
            validator: (value) =>
                notEmptyDropdownOption(value, "Municipalidad requerida"),
            isLoading: controller.isLoadingMunicipalityHome,
            listItems: controller.municipalitiesHome,
            onSelected: (DropDownOption option) {
              controller.municipalityHomeController.value = option;
            },
            label: "Municipio de domicilio",
            hintText: "",
            resetValue: controller.municipalityHomeController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .municipalitiesHome
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.residenceDepartmentController.value,
            prefixIcon: Icons.location_city_rounded,
            validator: (value) => notEmptyDropdownOption(
                value, "departamento de vecindad requerida"),
            isLoading: controller.isLoadingResidenceDepartment,
            listItems: controller.residenceDepartments,
            onSelected: (DropDownOption option) async {
              controller.residenceDepartmentController.value = option;
              controller.isLoadingResidenceMunicipality.value = true;
              controller.residenceMunicipalities.value = await controller
                  .genericListController
                  .fetchMunicipalities(option.id);
              controller.isLoadingResidenceMunicipality.value = false;
            },
            label: "Departamento de vecindad",
            hintText: "",
            resetValue: controller.residenceDepartmentController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .residenceDepartments
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.residenceMunicipalityController.value,
            prefixIcon: Icons.location_city_rounded,
            validator: (value) => notEmptyDropdownOption(
                value, "Municipalidad de vecindad requerida"),
            isLoading: controller.isLoadingResidenceMunicipality,
            listItems: controller.residenceMunicipalities,
            onSelected: (DropDownOption option) {
              controller.residenceMunicipalityController.value = option;
            },
            label: "Municipio de vecindad",
            hintText: "",
            resetValue: controller.residenceMunicipalityController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .residenceMunicipalities
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.countryOfBirthController.value,
            prefixIcon: Icons.public,
            validator: (value) =>
                notEmptyDropdownOption(value, "País de nacimiento requerido"),
            isLoading: controller.genericListController.isLoadingCountry,
            listItems: controller.genericListController.countries,
            onSelected: (DropDownOption option) {
              controller.countryOfBirthController.value = option;
            },
            label: "País de nacimiento",
            hintText: "",
            resetValue: controller.countryOfBirthController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.countries
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),

          LoadingAutocompleteDropdown(
            enabled: enabled,
            initialValue: controller.municipalityOfBirthController.value,
            prefixIcon: Icons.location_city_rounded,
            validator: (value) =>
                notEmptyDropdownOption(value, "Municipio de nacimiento requerido"),
            isLoading: controller.isLoadingMunicipalityOfBirth,
            listItems: controller.municipalitiesOfBirth,
            onSelected: (DropDownOption option) {
              controller.municipalityOfBirthController.value = option;
            },
            label: "Municipio de nacimiento",
            hintText: "",
            resetValue: controller.municipalityOfBirthController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .municipalitiesOfBirth
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
        ],
      );
    }),
  );
}
