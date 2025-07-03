import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_checkBox_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget licenceWeapon(BuildContext context, EmployeeAgentController controller) {
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
            child: Row(
              children: [
                const Icon(Icons.security),
                const SizedBox(width: 10),
                const Text("¿Permiso de Arma?"),
                const SizedBox(width: 10),
                Obx(() => CustomCheckbox(
                    value: controller.gunPermitController.value,
                    onChanged: (value) {
                      controller.gunPermitController.value = value!;
                    },
                    activeColor: Theme.of(context).colorScheme.primary,
                    unSelectedColor: Theme.of(context).colorScheme.surface,
                    checkColor: Theme.of(context).colorScheme.surface)),
              ],
            ),
          ),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.driverLicenseTypeController,
                  label: "Tipo Licencia de Conducir",
                  hintText: "",
                  prefixIcon: Icons.drive_eta)),
          SizedBox(
              width: width,
              child: CustomInputWidget(
                  controller: controller.driverLicenseNumberController,
                  label: "Número Licencia de Conducir",
                  hintText: "",
                  prefixIcon: Icons.confirmation_number)),
        ],
      );
    }),
  );
}
