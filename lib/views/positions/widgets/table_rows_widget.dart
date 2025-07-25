import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

List<DataRow> buildTablePositionRows(PositionController controller,
    BuildContext context, EmployeeAgentController? employeeController) {
  LoaderController loaderController =
      Get.put<LoaderController>(LoaderController());

  return List.generate(
    controller.positions.length,
    (index) {
      final PositionModel element = controller.positions.elementAt(index);
      return DataRow(
        cells: [
          if (employeeController == null)
            DataCell(Row(
              children: [
                editPositionButton(context, element.id.toString()),
                deletePositionButton(context, element.id.toString()),
              ],
            )),
          if (employeeController != null)
            DataCell(Row(
              children: [
                IconButton(
                  tooltip: "Crear nuevo agente vinculado a esta proseña",
                  icon: const Icon(Icons.person),
                  onPressed: () async {
                    // print("object ${element.positionName}");
                    await Navigator.pushNamed(
                        context, RouteConstants.manageEmployee,
                        arguments: {
                          'position': element,
                          'employeeType': "Permanente",
                        });
                    // print("object ${element.positionName}");
                    loaderController.show();
                    controller.positions.clear();
                    await Future.delayed(const Duration(seconds: 1));
                    await controller.fetchPositions();
                    loaderController.hide();
                  },
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.work),
                  tooltip: "Asignar proseña a empleado",
                  color: Theme.of(context).colorScheme.onSurface,
                ),
               
                IconButton(
                  onPressed: () {},
                  tooltip: "Quitar proseña a empleado",
                  icon: const Icon(Icons.no_accounts_rounded),
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ],
            )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.name, context: context),
          cellDataTable(element.latitude, context: context),
          cellDataTable(element.longitude, context: context),
          // cellDataTable(element.prosena, context: context),
          cellDataTable(element.group?.name ?? "", context: context),
          cellDataTable(element.branch?.name, context: context),
          cellDataTable(element.shiftTime?.name, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}
