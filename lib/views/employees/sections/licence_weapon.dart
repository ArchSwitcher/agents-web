import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget licenceWeapon(BuildContext context, EmployeeController controller) {
  return ContentCard(
    child: LayoutBuilder(builder: (context, constraints) {
      final isWideScreen = constraints.maxWidth > 750;
      final width = isWideScreen ? (constraints.maxWidth / 4) - 40 : constraints.maxWidth - 40;
    
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.spaceBetween,
        children: [
          SizedBox(width: width, child: CustomInputWidget(controller: controller.driverLicenseTypeController, label: "Tipo Licencia de Conducir", hintText: "", prefixIcon: Icons.drive_eta)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.driverLicenseNumberController, label: "Número Licencia de Conducir", hintText: "", prefixIcon: Icons.confirmation_number)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.gunPermitController, label: "Permiso de Arma", hintText: "", prefixIcon: Icons.security)),
    
        ],
      );
    }),
  );
}