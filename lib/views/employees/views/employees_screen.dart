import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/views/employees/widgets/action_btns.dart';
import 'package:agents_app/views/positions/widgets/table_rows_widget.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeesScreen extends StatefulWidget {
  const EmployeesScreen({super.key});

  @override
  EmployeesScreenState createState() => EmployeesScreenState();
}

class EmployeesScreenState extends State<EmployeesScreen> {
  final EmployeeController controller =
      Get.put<EmployeeController>(EmployeeController());
  final LoaderController loaderController = Get.find<LoaderController>();

  final List<String> headers = [
    "",
    'Código',
    'Nombre',
    'Latitud',
    'Longitud',
    "proseña",
    "Agencia",
    "Sucursal",
    "Horario"
  ];

  start() async {
    loaderController.show();
    await controller.positionController.fetchPositions();
    loaderController.hide();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Empleados',
        description: "Gestión de empleados",
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
                          hint: "Buscar",
                          label: "Buscar",
                        ),
                      ),
                      SizedBox(
                        width: 230,
                        child: addTemporalEmployeeButton(context, controller),
                      )
                    ]),
              ),

              // table content, edit delete elements
              cardContentSpace(),

              ContentCard(child: Obx(() {
                return CustomDataTableWidgetV2(
                    minWidth: 1680,
                    dynamicHeight: false,
                    tableHeight: TableHelper.getTableHeight(
                        controller.positionController.positions),
                    tableHeaders: headers,
                    tableRows: buildTablePositionRows(
                        controller.positionController, context, controller));
              }))
            ],
          ),
        ));
  }
}
