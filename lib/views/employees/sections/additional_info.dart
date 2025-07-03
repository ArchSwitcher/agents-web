import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:flutter/material.dart';

Widget additionalInfo(BuildContext context, EmployeeController controller) {
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
            SizedBox(width: width, child: CustomInputWidget(controller: controller.lifeInsuranceController, label: "Seguro de Vida", hintText: "", prefixIcon: Icons.health_and_safety)),
            SizedBox(width: width, child: CustomDatePicker(controller: controller.shootingPracticeController, label: "Fecha de Práctica de Tiro", initialDate: DateTime.now(),  hintText: "", prefixIcon: Icons.adjust)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.graduationScoreController, label: "Puntaje de Graduación", hintText: "", prefixIcon: Icons.grade)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.referredByController, label: "Referido Por", hintText: "", prefixIcon: Icons.person_add)),
        ],
      );
    }),
  );
}