import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget systemAccessStatus(BuildContext context, EmployeeController controller) {
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
          SizedBox(width: width, child: CustomInputWidget(controller: controller.stateController, label: "Estado", hintText: "", prefixIcon: Icons.toggle_on)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.accessUserController, label: "Usuario de Acceso", hintText: "", prefixIcon: Icons.person)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.billableController, label: "Facturable", hintText: "", prefixIcon: Icons.attach_money)),
          SizedBox(width: width, child: CustomInputWidget(controller: controller.approvedByPaymentsController, label: "Aprobado por Pagos", hintText: "", prefixIcon: Icons.approval)),
        ],
      );
    }),
  );
}