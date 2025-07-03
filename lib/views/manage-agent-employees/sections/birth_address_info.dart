import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget birthAddressInfo(BuildContext context, EmployeeAgentController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 750;
      final width = isWideScreen
          ? (constraints.maxWidth / 3) - 40
          : constraints.maxWidth - 40;

      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          LoadingAutocompleteDropdown(
            initialValue: controller.birthCountryController.value,
            prefixIcon: Icons.flag,
            validator: (value) =>
                notEmptyDropdownOption(value, "País requerido"),
            enabled: true,
            isLoading: controller.genericListController.isLoadingCountry,
            listItems: controller.genericListController.countries,
            onSelected: (DropDownOption option) {
              controller.birthCountryController.value = option;
            },
            label: "Dirección fiscal",
            hintText: "País",
            resetValue: controller.birthCountryController,
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
            initialValue: controller.birthDepartmentController.value,
            prefixIcon: Icons.map,
            validator: (value) =>
                notEmptyDropdownOption(value, "Departamento requerido"),
            enabled: true,
            isLoading: controller.genericListController.isLoadingCity,
            listItems: controller.genericListController.departments,
            onSelected: (DropDownOption option) async {
              controller.birthDepartmentController.value = option;

              controller.isLoadingBirthMunicipalities.value = true;
              controller.birthMunicipalities.value = await controller
                  .genericListController
                  .fetchMunicipalitiesOnly(option.id);
              controller.isLoadingBirthMunicipalities.value = false;
            },
            label: "Departamento de nacimiento",
            hintText: "Departamento",
            resetValue: controller.birthDepartmentController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.departments
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            initialValue: controller.birthMunicipalityController.value,
            prefixIcon: Icons.location_city,
            validator: (value) =>
                notEmptyDropdownOption(value, "Municipio requerido"),
            enabled: true,
            isLoading: controller.isLoadingBirthMunicipalities,
            listItems: controller.birthMunicipalities,
            onSelected: (DropDownOption option) {
              controller.birthMunicipalityController.value = option;
            },
            label: "Municipio de nacimiento",
            hintText: "Municipio",
            resetValue: controller.birthMunicipalityController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .birthMunicipalities
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            initialValue: controller.addressDepartmentController.value,
            prefixIcon: Icons.map,
            validator: (value) => notEmptyDropdownOption(
                value, "Departamento de residencia requerido"),
            enabled: true,
            isLoading: controller.genericListController.isLoadingCity,
            listItems: controller.genericListController.departments,
            onSelected: (DropDownOption option) async{
              controller.addressDepartmentController.value = option;
              controller.isLoadingAddressMunicipalities.value = true;
              controller.addressMunicipalities.value = await controller
                  .genericListController
                  .fetchMunicipalitiesOnly(
                      controller.addressDepartmentController.value.id);
              controller.isLoadingAddressMunicipalities.value = false;
            },
            label: "Departamento de residencia",
            hintText: "Departamento",
            resetValue: controller.addressDepartmentController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .genericListController.departments
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          LoadingAutocompleteDropdown(
            initialValue: controller.addressMunicipalityController.value,
            prefixIcon: Icons.home,
            validator: (value) => notEmptyDropdownOption(
                value, "Municipio de residencia requerido"),
            enabled: true,
            isLoading: controller.isLoadingAddressMunicipalities,
            listItems: controller.addressMunicipalities,
            onSelected: (DropDownOption option) {
              controller.addressMunicipalityController.value = option;
            },
            label: "Municipio de residencia",
            hintText: "Municipio",
            resetValue: controller.addressMunicipalityController,
            width: width,
            onTextChange: (text) async {
              List<DropDownOption> filteredOptions = controller
                  .addressMunicipalities
                  .where((option) =>
                      option.label.toLowerCase().contains(text.toLowerCase()))
                  .toList();
              return filteredOptions.isEmpty ? [] : filteredOptions;
            },
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.addressController,
              label: "Dirección",
              hintText: "",
              prefixIcon: Icons.location_on,
            ),
          ),
        ],
      );
    }),
  );
}
