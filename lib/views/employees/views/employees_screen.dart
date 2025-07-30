import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
// import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:agents_app/views/employees/widgets/action_btns.dart';
import 'package:agents_app/views/employees/widgets/modal_assign_equipment.dart';
import 'package:agents_app/views/employees/widgets/search_modal.dart';
import 'package:agents_app/views/equipment/widgets/asigment_equipment_modal.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
// import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/data_table_local.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({Key? key}) : super(key: key);

  @override
  _EmployeesScreenState createState() => _EmployeesScreenState();
}

class _EmployeesScreenState extends State<EmployeesScreen> {
  final EmployeeController controller = Get.put(EmployeeController());
  final List<String> tableHeaders = [
    '',
    'Código',
    'Nombre completo',
    'Email',
    'Teléfono',
    'Agencia',
    'Fecha de ingreso',
    'Fecha de nacimiento'
  ];

  final List<double?> fixedColumnWidths = [
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null,
    null
  ];
  bool isSearched = false;
  start() async {
    await controller.fetchEmployees();
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Aprobación de altas',
        description: "Configuración de empleados",
        currentRoute: RouteConstants.employees,
        userRole: 'admin',
        content: SingleChildScrollView(
          child: Column(
            children: [
              // add new group
              ContentCard(
                child: Wrap(
                  spacing: 30, // espacio horizontal entre widgets
                  runSpacing:
                      20, // espacio vertical entre líneas si se hace wrap
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.end,
                  children: [
                    searchEmployeeButton(context, controller, () async {
                      await controller.searchEmployees();
                      isSearched = true;
                      setState(() {});
                    }),
                    if (isSearched)
                      SizedBox(
                        width: 220,
                        child: ElevatedButton.icon(
                            onPressed: () async {
                              controller.searchNameController.clear();
                              await controller.fetchEmployees();
                              isSearched = false;
                              setState(() {});
                            },
                            label: const Text("Limpiar búsqueda"),
                            icon: const Icon(Icons.clear)),
                      ),
                    SizedBox(
                      width: 180,
                      child: addEmployeeButton(context),
                    )
                  ],
                ),
              ),

              // table content, edit delete elements
              cardContentSpace(),
              ContentCard(
                  child: CustomPaginatedDataTableWidget(
                data: controller.employees,
                columns: tableHeaders
                    .map((header) => DataColumn(label: Text(header)))
                    .toList(),
                buildRows: (list) => buildTableRowsFromList(
                    controller.employees, context, controller),
                rowsPerPage: 100,
              ))
            ],
          ),
        ));
  }
}

List<DataRow> buildTableRowsFromList(
    List<EmployeeModel> list, BuildContext context, EmployeeController controller) {
  return List.generate(list.length, (index) {
    final element = list[index];
    final String fullName =
        '${element.firstName ?? ''} ${element.middleName ?? ''} ${element.lastName ?? ''} ${element.secondLastName ?? ''}'
            .trim();
    return DataRow(
      cells: [
        DataCell(Row(children: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(
              onPressed: () {
                showAssignEquipmentModal(context: context);
              },
              icon: const Icon(Icons.add_shopping_cart)),

          IconButton(
            onPressed: () {
              // Logic for equipment assignment
              showAssignmentEquipmentModal(
                  context: context, employeeId: element.id!);
            },
            icon: const Icon(Icons.assignment),
            tooltip: 'Equipo asignado',
          ),
          changeStatusEmployeeButton(context, element, () async {
            controller.changeEmployeeStatus();
          }),
          editEmployeeButton(context, element),
        ])),
        cellDataTable(element.id ?? "", context: context),
        cellDataTable(element.fullName ?? fullName, context: context),
        cellDataTable(element.email, context: context),
        cellDataTable(element.mobile, context: context),
        cellDataTable(element.agency?.name ?? "", context: context),
        cellDataTable(element.hireDate, context: context),
        cellDataTable(element.birthDate ?? "", context: context),
      ],
      color: colorRowDataTable(index, context),
    );
  });
}
