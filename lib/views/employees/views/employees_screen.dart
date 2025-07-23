import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
// import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:agents_app/views/employees/widgets/modal_assign_equipment.dart';
import 'package:agents_app/views/equipment/widgets/asigment_equipment_modal.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
// import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/data_table_local.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
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
    'Nombre',
    'Apellido',
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

  start() async {
    await controller.fetchEmployees();
    setState(() {
      
    });
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
        title: 'Empleados',
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
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 300,
                        maxWidth: 600,
                      ),
                      child: FilterBox(
                        elements: [],
                        handleFilteredData: (List<dynamic> data) {},
                        isLoading: false,
                        hint: "Buscar grupos",
                        label: "Buscar grupo",
                      ),
                    ),
                    // SizedBox(
                    //   width: 160,
                    //   child: Text(
                    //       "añadir empleado"), // Placeholder for add employee button
                    // )
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
                buildRows: (list) =>
                    buildTableRowsFromList(controller.employees, context),
                rowsPerPage: 100,
              ))
              // ContentCard(child: Obx(() {
              //   return CustomDataTableWidgetV2(
              //       // minWidth: 1,
              //       // dynamicHeight: false,
              //       tableHeight:
              //           TableHelper.getTableHeight(controller.employees),
              //       fixedColumnWidths: fixedColumnWidths,
              //       // columnSizes: columnSizes,
              //       tableHeaders: tableHeaders,
              //       tableRows: _buildTableRows(controller, context));
              // }))
            ],
          ),
        ));
  }
}

// List<DataRow> _buildTableRows(
//     EmployeeController controller, BuildContext context) {
//   return List.generate(
//     controller.employees.length,
//     (index) {
//       final EmployeeModel element = controller.employees.elementAt(index);

//       return DataRow(
//         cells: [
//           DataCell(Row(
//             children: [
//               // Text("${element.firstName}"),
//               // editEmployeeButton(context, element),
//               // deleteEmployeeButton(context, element.id.toString()),
//             ],
//           )),
//           cellDataTable(element.id, context: context),
//           cellDataTable(element.firstName, context: context),
//           cellDataTable(element.lastName, context: context),
//           cellDataTable(element.email, context: context),
//           cellDataTable(element.phone, context: context),
//           cellDataTable(element.agency, context: context),
//           cellDataTable(element.entryDate, context: context),
//           cellDataTable(element.birthDate, context: context),
//         ],
//         color: colorRowDataTable(index, context),
//       );
//     },
//   );
// }

List<DataRow> buildTableRowsFromList(
    List<EmployeeModel> list, BuildContext context) {
  return List.generate(list.length, (index) {
    final element = list[index];
    return DataRow(
      cells: [
        DataCell(Row(children: [
          // IconButton(onPressed: () {}, icon: Icon(Icons.edit)),
          IconButton(onPressed: () {
            showAssignEquipmentModal(context: context);
          }, icon: Icon(Icons.add_shopping_cart)),

          IconButton(
            onPressed: () {
              // Logic for equipment assignment
              showAssignmentEquipmentModal(context: context, employeeId: element.id!);
            },
            icon: Icon(Icons.assignment),
            tooltip: 'Assign Equipment',
          ),
        ])),
        cellDataTable(element.id, context: context),
        cellDataTable(element.firstName, context: context),
        cellDataTable(element.lastName, context: context),
        cellDataTable(element.email, context: context),
        cellDataTable(element.phone, context: context),
        cellDataTable(element.agency, context: context),
        cellDataTable(element.entryDate, context: context),
        cellDataTable(element.birthDate, context: context),
      ],
      color: colorRowDataTable(index, context),
    );
  });
}
