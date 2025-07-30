import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:agents_app/views/employees/widgets/modal_down_employee.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
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

Widget searchEmployeeButton(
    BuildContext context, EmployeeController controller, VoidCallback? onAccept) {
  final colorScheme = Theme.of(context).colorScheme;
  return ElevatedButton.icon(
      label: const Text("Buscar empleado"),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Buscar Empleado"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomInputWidget(
                      label: "Buscar por nombre",
                      hintText: "",
                      prefixIcon: Icons.person,
                      controller: controller.searchNameController ,
                    ),
                    // const SizedBox(height: 10),
                    // CustomInputWidget(
                    //   label: "Buscar por cliente",
                    //   hintText: "",
                    //   prefixIcon: Icons.business_outlined,
                    //   controller: controller.controllerSearchClient,
                    // ),
                    // const SizedBox(height: 10),
                    // CustomInputWidget(
                    //   label: "Buscar por grupo",
                    //   hintText: "",
                    //   prefixIcon: Icons.group,
                    //   controller: controller.controllerSearchGroup,
                    // ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child:const Text("Cerrar"),
                  ),
                  TextButton(
                    onPressed: () {
                      onAccept?.call();
                      Navigator.of(context).pop();
                    },
                    child:const Text("Buscar"),
                  ),
                ],
              );
            });
      },
      icon: Icon(
        Icons.search,
        color: colorScheme.onSurface,
        size: 20,
      ));
}
