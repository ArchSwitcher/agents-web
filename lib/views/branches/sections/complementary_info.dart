import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/helpers/validations/dropdown_validator.dart';
import 'package:agents_app/shared/helpers/validations/grater_than_number_validator.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/commons/loading.dart';
import 'package:agents_app/widgets/inputs/autocomplete_dropdown.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget complementaryInfo(BranchController controller) {
  return ContentCard(
      child: Column(
    children: [
      LayoutBuilder(builder: (context, constraints) {
        final isWideScreen = constraints.maxWidth > 700;
        final width = isWideScreen
            ? (constraints.maxWidth / 4) - 40
            : constraints.maxWidth - 40;
        return Wrap(
          spacing: 30,
          runSpacing: 20,
          crossAxisAlignment: WrapCrossAlignment.center,
          alignment: WrapAlignment.spaceBetween,
          direction: isWideScreen ? Axis.horizontal : Axis.vertical,
          children: [
            Obx(() {
              if (controller
                  .genericListController.isLoadingClassification.value) {
                return SizedBox(
                    width: width,
                    child: const Align(
                        alignment: Alignment.centerLeft, child: Loading()));
              }
              return SizedBox(
                width: width,
                child: AutocompleteDropdownWidget(
                  validator: (value) =>
                      notEmptyFieldValidator("Clasificación requerida"),
                  enabled: true,
                  listItems: controller.genericListController.classification,
                  onSelected: (DropDownOption option) {
                    controller.classification.value = option;
                  },
                  initialValue: controller.classification.value,
                  label: "Clasificación",
                  hintText: "Clasificación",
                  onFocusChange: (hasFocus) {},
                  resetClean: (clean) {
                    controller.classification.value = DropDownOption(
                      id: '',
                      label: 'Seleccione una clasificación',
                    );
                  },
                  onTextChange: (text) async {
                    List<DropDownOption> filteredOptions = controller
                        .genericListController.classification
                        .where((option) => option.label
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    return filteredOptions.isEmpty
                        ? []
                        : filteredOptions;
                  },
                ),
              );
            }),
            Obx(() {
              if (controller.genericListController.isLoadingFactory.value) {
                return SizedBox(
                    width: width,
                    child: const Align(
                        alignment: Alignment.centerLeft, child: Loading()));
              }
              return SizedBox(
                width: width,
                child: AutocompleteDropdownWidget(
                  validator: (value) =>
                      notEmptyDropdownOption(value, "Fábrica requerida"),
                  enabled: true,
                  listItems: controller.genericListController.factories,
                  onSelected: (DropDownOption option) {
                    controller.factory.value = option;
                  },
                  initialValue: controller.factory.value,
                  label: "Fábrica",
                  hintText: "Fábrica",
                  onFocusChange: (hasFocus) {},
                  resetClean: (clean) {
                    controller.factory.value = DropDownOption(
                      id: '',
                      label: 'Seleccione una fábrica',
                    );
                  },
                  onTextChange: (text) async {
                    List<DropDownOption> filteredOptions = controller
                        .genericListController.factories
                        .where((option) => option.label
                            .toLowerCase()
                            .contains(text.toLowerCase()))
                        .toList();
                    return filteredOptions.isEmpty
                        ? []
                        : filteredOptions;
                  },
                ),
              );
            }),
            SizedBox(
              width: width,
              child: CustomInputWidget(
                controller: controller.latitudeController,
                label: "Latitud",
                hintText: "Ingrese la latitud",
                validator: (value) => notEmptyFieldValidator(value),
                prefixIcon: Icons.location_on,
              ),
            ),
            SizedBox(
              width: width,
              child: CustomInputWidget(
                controller: controller.longitudeController,
                validator: (value) => notEmptyFieldValidator(value),
                label: "Longitud",
                hintText: "Ingrese la longitud",
                prefixIcon: Icons.location_on,
              ),
            ),
            SizedBox(
              width: width,
              child: CustomInputWidget(
                controller: controller.radiusController,
                validator: (value) =>
                    graterThanNumberValidator(value, 0) == true
                        ? null
                        : "El radio debe ser mayor a 0",
                label: "Radio de cobertura",
                hintText: "Ingrese el radio de cobertura",
                prefixIcon: Icons.location_on,
              ),
            ),
            SizedBox(
              width: width,
              child: CustomTimePicker(
                initialTime: controller.initTimeController.text.isNotEmpty
                  ? TimeOfDay(
                    hour: int.parse(controller.initTimeController.text.split(":")[0]),
                    minute: int.parse(controller.initTimeController.text.split(":")[1]),
                    )
                  : const TimeOfDay(hour: 0, minute: 0),
                controller: controller.initTimeController,
                label: 'Hora de inicio',
                hintText: 'Seleccione la hora',
                prefixIcon: Icons.access_time,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Hora de inicio es requerida';
                  }
                  return null;
                },
              ),
            ),
            //endtimecontroller
            SizedBox(
              width: width,
              child: CustomTimePicker(
                initialTime: controller.endTimeController.text.isNotEmpty
                  ? TimeOfDay(
                    hour: int.parse(controller.endTimeController.text.split(":")[0]),
                    minute: int.parse(controller.endTimeController.text.split(":")[1]),
                    )
                  : const TimeOfDay(hour: 0, minute: 0),
                controller: controller.endTimeController,
                label: 'Hora de fin',
                hintText: 'Seleccione la hora',
                prefixIcon: Icons.access_time,
                // validator: (value) =>
                //     endTimeValidator(value, controller.endTimeController.text),
              ),
            ),

            SizedBox(
              width: width,
            )
          ],
        );
      }),
    ],
  ));
}
