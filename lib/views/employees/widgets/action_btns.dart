import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/employees/widgets/modal_down_employee.dart';
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

Widget downEmployeeButton(BuildContext context, EmployeeModel employee) {
  final String fullName =
      '${employee.firstName ?? ''} ${employee.middleName ?? ''} ${employee.lastName ?? ''} ${employee.lastName ?? ''}'
          .trim();
  return IconButton(
      onPressed: () {
        downEmployeeModal(
            context: context,
            title: "dar de baja a empleado ${employee.fullName ?? fullName}",
            employeeStatus: employee.status,
            terminationDate: employee.terminationDate?.toIso8601String() ?? "",
            terminationReason: employee.terminationReason ?? "",
            );
      },
      tooltip: employee.status != true ? "Información del empleado de baja" : "Dar de baja al empleado",
      icon: Icon(employee.status == true
          ? Icons.arrow_downward
          : Icons.person_off_sharp));
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
