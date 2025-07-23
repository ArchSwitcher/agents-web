import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/mocks/personal_info_mocks.dart';
// import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
// import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/views/manage-agent-employees/widgets/action_btns.dart';
import 'package:agents_app/views/positions/widgets/table_rows_widget.dart';
// import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/data_table_local.dart';
// import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:agents_app/widgets/inputs/custom_dropdownv2_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmployeesAgentScreen extends StatefulWidget {
  const EmployeesAgentScreen({super.key});

  @override
  EmployeesAgentScreenState createState() => EmployeesAgentScreenState();
}

class EmployeesAgentScreenState extends State<EmployeesAgentScreen> {
  final EmployeeAgentController controller =
      Get.put<EmployeeAgentController>(EmployeeAgentController());
  final LoaderController loaderController = Get.find<LoaderController>();

  final List<String> headers = [
    "",
    'Código',
    'Nombre',
    'Latitud',
    'Longitud',
    "proseña",
    "Grupo",
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
  void didUpdateWidget(covariant EmployeesAgentScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("didUpdateWidget");
  }

  reloadPositions(String statusTypeId) async {
    loaderController.show();
    print(
        "controller.selectedPosition.text ${controller.selectedPosition.text} $statusTypeId");
    await controller.positionController
        .fetchPositions(statusType: statusTypeId);
    loaderController.hide();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
        title: 'Empleados',
        description: "Gestión de empleados",
        currentRoute: RouteConstants.manageAgent,
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
                      // ConstrainedBox(
                      //   constraints: const BoxConstraints(
                      //     minWidth: 300,
                      //     maxWidth: 400,
                      //   ),
                      //   child: FilterBox(
                      //     cleanValue: () {},
                      //     elements: [...controller.positionController.positions],
                      //     handleFilteredData: (List<PositionModel> data) {
                      //       controller.positionController.positions.value = data;
                      //       setState(() {
                              
                      //       });
                      //     },
                      //     isLoading: false,
                      //     hint: "Buscar",
                      //     label: "Buscar",
                      //   ),
                      // ),
                      SizedBox(
                        width: 250,
                        child: CustomDropdownV2Widget(
                            initialValue: statusTypePositionMock.last,
                            labelText: "Status de posición",
                            hintText: "",
                            items: statusTypePositionMock,
                            validator: (p0) => null,
                            prefixIcon: const Icon(Icons.location_on),
                            textEditingController: controller.selectedPosition,
                            onValueChanged: (v) async {
                              controller.selectedPosition.text =
                                  v!.label.toString();
                              // controller.positionController.clearPositions();
                              await reloadPositions(v.id);
                            }),
                      ),
                      SizedBox(
                        width: 230,
                        child: addTemporalEmployeeButton(context, controller),
                      )
                    ]),
              ),

              // table content, edit delete elements
              cardContentSpace(),

              // ContentCard(child: Obx(() {
              //   return CustomDataTableWidgetV2(
              //       minWidth: 1680,
              //       dynamicHeight: false,
              //       tableHeight: TableHelper.getTableHeight(
              //           controller.positionController.positions),
              //       tableHeaders: headers,
              //       tableRows: buildTablePositionRows(
              //           controller.positionController, context, controller));
              // }))

              ContentCard(
                  child: CustomPaginatedDataTableWidget(
                data: controller.positionController.positions,
                columns: headers
                    .map((header) => DataColumn(label: Text(header)))
                    .toList(),
                buildRows: (list) => buildTablePositionRows(
                    controller.positionController, context, null),
                rowsPerPage: 100,
              ))
            ],
          ),
        ));
  }
}
