import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget buildEmergencyContact(
    BuildContext context, EmployeeController controller) {
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
                    controller: controller.emergencyRelationshipController,
                    label: "Parentesco Emergencia",
                    hintText: "",
                    prefixIcon: Icons.group)),
            SizedBox(
                width: width,
                child: CustomInputWidget(
                    controller: controller.emergencyNameController,
                    label: "Nombre Contacto Emergencia",
                    hintText: "",
                    prefixIcon: Icons.person)),
            SizedBox(
                width: width,
                child: CustomInputWidget(
                    controller: controller.emergencyPhoneController,
                    label: "Teléfono Emergencia",
                    hintText: "",
                    prefixIcon: Icons.phone)),
            SizedBox(
                width: width,
                child: CustomInputWidget(
                    controller: controller.emergencyMobileController,
                    label: "Celular Emergencia",
                    hintText: "",
                    prefixIcon: Icons.phone_android)),
          ]);
    }),
  );
}
