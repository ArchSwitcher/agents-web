import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/custom_label_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget basicInfo(BranchController controller) {
  return ContentCard(
    child: Column(
      children: [
        LayoutBuilder(builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          final width = isWideScreen
              ? (constraints.maxWidth / 3) - 40
              : constraints.maxWidth - 40;
          return Wrap(
            spacing: 30,
            runSpacing: 20,
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.spaceBetween,
            direction: isWideScreen ? Axis.horizontal : Axis.vertical,
            children: [
              LoadingAutocompleteDropdown(
                validator: (value) =>
                    notEmptyDropdownOption(value, "Grupo requerido"),
                initialValue: controller.groupId.value,
                prefixIcon: Icons.group,
                enabled: true,
                isLoading: controller.groupController.isLoading,
                listItems: controller.groupController.dropdownOptions,
                onSelected: (DropDownOption option) {
                  controller.groupId.value = option;
                  controller.genericListController
                      .fetchClientsByGroupId(option.id);
                  controller.client.value = DropDownOption(id: "", label: "");
                  controller.genericListController.cleanClientsByGroup();
                },
                label: "Grupo",
                hintText: "Grupo",
                resetValue: controller.groupId,
                width: width,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .groupController.dropdownOptions
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty ? [] : filteredOptions;
                },
              ),
              //loading dropdown client
              LoadingAutocompleteDropdown(
                validator: (value) =>
                    notEmptyDropdownOption(value, "Cliente requerido"),
                initialValue: controller.client.value,
                loadingText: controller
                        .genericListController.isLoadingClientsByGroup.value
                    ? "Seleccione un grupo para ver clientes"
                    : "",
                prefixIcon: Icons.business,
                enabled: true,
                isLoading:
                    controller.genericListController.isLoadingClientsByGroup,
                listItems:
                    controller.genericListController.clientsByGroup.isEmpty
                        ? []
                        : controller.genericListController.clientsByGroup,
                onSelected: (DropDownOption option) {
                  controller.client.value = option;
                },
                label: "Cliente",
                hintText: "Cliente",
                resetValue: controller.client,
                width: width,
                onTextChange: (text) async {
                  List<DropDownOption> filteredOptions = controller
                      .genericListController.clientsByGroup
                      .where((option) => option.label
                          .toLowerCase()
                          .contains(text.toLowerCase()))
                      .toList();
                  return filteredOptions.isEmpty ? [] : filteredOptions;
                },
              ),
              SizedBox(
                width: width,
                child: CustomInputWidget(
                  controller: controller.socialReasonController,
                  label: "Razón Social",
                  hintText: "Ingrese la razón social",
                  prefixIcon: Icons.business,
                ),
              ),
            ],
          );
        }),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWideScreen = constraints.maxWidth > 600;
            final width = isWideScreen
                ? (constraints.maxWidth / 3) - 40
                : constraints.maxWidth - 40;
            return Wrap(
              spacing: 30,
              runSpacing: 20,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              direction: isWideScreen ? Axis.horizontal : Axis.vertical,
              children: [
                SizedBox(
                  width: width,
                  child: CustomInputWidget(
                    controller: controller.nitController,
                    label: "Nit",
                    hintText: "Ingrese el nit",
                    prefixIcon: Icons.numbers,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: CustomInputWidget(
                    controller: controller.codeGpController,
                    label: "Código GP",
                    hintText: "Ingrese el código GP",
                    prefixIcon: Icons.code,
                  ),
                ),
                SizedBox(
                  width: width,
                  child: CustomInputWidget(
                    validator: (value) => notEmptyFieldValidator(value),
                    controller: controller.nameController,
                    label: "Nombre*",
                    hintText: "Nombre de la sucursal",
                    prefixIcon: Icons.business_sharp,
                  ),
                ),
                SizedBox(
                    width: width,
                    child: CustomLabelWidget(
                        title: "País",
                        label: "Guatemala",
                        prefixIcon: Icons.public)),
                SizedBox(
                  width: width,
                  child: CustomLabelWidget(
                    title: "Estado",
                    label: "ALTA",
                    prefixIcon: Icons.check_circle_outline,
                  ),
                ),
                SizedBox(width: width)
              ],
            );
          },
        ),
      ],
    ),
  );
}
