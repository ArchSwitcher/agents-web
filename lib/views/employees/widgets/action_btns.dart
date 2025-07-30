import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/employees/widgets/modal_change_status_employee.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';

import 'package:flutter/material.dart';

Widget addEmployeeButton(BuildContext context) {
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
            "Nuevo empleado",
            style: CustomStyle.textStyleWhite(context),
          ),
        ],
      ),
      isLoading: false,
      onPress: () async {
        Navigator.pushNamed(context, RouteConstants.manageEmployee, arguments: {
          'position': null,
          // 'employeeType': "Temporal",
        });
      });
}

Widget changeStatusEmployeeButton(
    BuildContext context, EmployeeModel employee, VoidCallback? onAccept) {
  final String fullName =
      '${employee.firstName ?? ''} ${employee.middleName ?? ''} ${employee.lastName ?? ''} ${employee.lastName ?? ''}'
          .trim();
  IconData newIcon = Icons.published_with_changes_rounded;
  if (employee.workerStatusId == 2) {
    newIcon = Icons.person_remove_rounded;
  } else if (employee.workerStatusId == 3) {
    newIcon = Icons.personal_injury;
  } else if (employee.workerStatusId == 4) {
    newIcon = Icons.person_off_sharp;
  }

  return IconButton(
      onPressed: () {
        changeStatusEmployeeModal(
            context: context,
            title: "Cambiar estado ${employee.fullName ?? fullName}",
            employeeStatus: employee.status,
            terminationDate: employee.terminationDate?.toIso8601String() ?? "",
            terminationReason: employee.terminationReason ?? "",
            employee: employee,
            onAccept: () {
              onAccept?.call();
              Navigator.of(context).pop();
            }
            );
      },
      tooltip: "Cambiar estado del empleado",
      icon: Icon(newIcon));
}

Widget editEmployeeButton(BuildContext context, EmployeeModel employee) {
  return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.manageEmployee, arguments: {
          'employeeId': employee.id,
        });
      },
      tooltip: "Editar empleado",
      icon: const Icon(Icons.edit));
}
