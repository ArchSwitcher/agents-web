import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget physicalAddressSection(BranchController controller) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 700;
    final width = isWideScreen
        ? (constraints.maxWidth / 5) - 40
        : constraints.maxWidth - 40;
    return Wrap(
      spacing: 30,
      runSpacing: 20,
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.spaceBetween,
      direction: isWideScreen ? Axis.horizontal : Axis.vertical,
      children: [
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.public,
          validator: (value) =>
              notEmptyDropdownOption(value, "País requerido"),
          enabled: true,
          isLoading: controller.genericListController.isLoadingCountry,
          listItems: controller.genericListController.countries,
          onSelected: (DropDownOption option) {
            controller.physicalCountry.value = option;
          },
          label: "Dirección fiscal",
          hintText: "País",
          resetValue: controller.physicalCountry,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.countries
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? []
                : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Department
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.business,
          enabled: true,
          isLoading: controller.genericListController.isLoadingCity,
          listItems: controller.genericListController.departments,
          validator: (value) =>
              notEmptyDropdownOption(value, "Departamento requerido"),
          onSelected: (DropDownOption option) {
            controller.physicalDepartment.value = option;

            controller.genericListController.fetchMunicipalities(option.id);
            controller.municipality.value = DropDownOption(id: "", label: "");
            controller.genericListController.cleanMunicipalities();
          },
          label: "",
          hintText: "Departamento",
          resetValue: controller.physicalDepartment,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.departments
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? []
                : filteredOptions;
          },
        ),
        LoadingAutocompleteDropdown(
          initialValue: controller.municipality.value,
          validator: (value) =>
              notEmptyDropdownOption(value, "Municipio requerido"),
          prefixIcon: Icons.apartment,
          enabled: true,
          isLoading: controller.genericListController.isLoadingMunicipality,
          listItems: controller.genericListController.municipalities,
          onSelected: (DropDownOption option) {
            controller.municipality.value = option;
          },
          label: "",
          hintText: "Municipio",
          resetValue: controller.municipality,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller.genericListController.municipalities
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),

        // LoadingAutocompleteDropdown for Zone
        LoadingAutocompleteDropdown(
          prefixIcon: Icons.map,
          validator: (value) =>
              notEmptyDropdownOption(value, "Zona requerida"),
          enabled: true,
          isLoading: controller.genericListController.isLoadingZone,
          listItems: controller.genericListController.zones,
          onSelected: (DropDownOption option) {
            controller.physicalZone.value = option;
          },
          label: "",
          hintText: "Zona",
          resetValue: controller.physicalZone,
          width: width,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = controller
                .genericListController.zones
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty
                ? []
                : filteredOptions;
          },
        ),
        SizedBox(
          width: width,
          child: CustomInputWidget(
            validator: (value) => notEmptyFieldValidator(value),
            controller: controller.physicalAddress,
            label: "",
            hintText: "Ingrese la dirección",
            prefixIcon: Icons.location_on,
          ),
        ),
      ],
    );
  });
}
