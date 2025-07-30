import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Widget addTemporalEmployeeButton(
    BuildContext context, ManageEmployeeController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.group_add,
            color: colorScheme.onSurface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nuevo Agente Temporal",
            style: CustomStyle.textStyleWhite(context),
          ),
        ],
      ),
      isLoading: false,
      onPress: () async {
        Navigator.pushNamed(context, RouteConstants.manageEmployee, arguments: {
          'position': null,
          'employeeType': "Temporal",
        });
      });
}
