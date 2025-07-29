import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget personalReference(
    BuildContext context, EmployeeAgentController controller, bool enabled) {
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
              enabled: enabled,
              controller: controller.referenceName1,
              label: "Referencia personal 1",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.referencePhone1,
              label: "Teléfono referencia 1",
              hintText: "",
              prefixIcon: Icons.phone,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.referenceName2,
              label: "Referencia personal 2",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.referencePhone2,
              label: "Teléfono referencia 2",
              hintText: "",
              prefixIcon: Icons.phone,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.referenceName3,
              label: "Referencia personal 3",
              hintText: "",
              prefixIcon: Icons.person,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(
            width: width,
            child: CustomInputWidget(
              enabled: enabled,
              controller: controller.referencePhone3,
              label: "Teléfono referencia 3",
              hintText: "",
              prefixIcon: Icons.phone,
              validator: (value) => notEmptyFieldValidator(value),
            ),
          ),
          SizedBox(width: width),
          SizedBox(width: width)
        ],
      );
    }),
  );
}
