import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget familyInfo(
    BuildContext context, ManageEmployeeController controller, bool enabled) {
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
              controller: controller.numberOfChildrenController,
              label: "Cantidad de hijos",
              hintText: "",
              prefixIcon: Icons.child_care_rounded,
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.emergencyNameController,
              label: "Nombre del contacto de emergencia",
              hintText: "",
              prefixIcon: Icons.person,
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              controller: controller.emergencyContactController,
              label: "Contacto de emergencia",
              hintText: "",
              prefixIcon: Icons.phone,
            ),
          ),
        ],
      );
    }),
  );
}
