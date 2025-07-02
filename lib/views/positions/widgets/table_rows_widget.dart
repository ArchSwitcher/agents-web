import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/employees/controllers/employee_controller.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';

List<DataRow> buildTablePositionRows(PositionController controller,
    BuildContext context, EmployeeController? employeeController) {
  return List.generate(
    controller.positions.length,
    (index) {
      final PositionModel element = controller.positions.elementAt(index);
      return DataRow(
        cells: [
          if (employeeController == null)
            DataCell(Row(
              children: [
                editPositionButton(context, element),
                deletePositionButton(context, element.id.toString()),
              ],
            )),
          if (employeeController != null)
            DataCell(Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.person),
                  onPressed: () {
                    Navigator.pushNamed(context, RouteConstants.manageEmployee,
                        arguments: {
                          'employeeId': element.id,
                          'positionName': element.positionName,
                        });
                  },
                ),
              ],
            )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.positionName, context: context),
          cellDataTable(element.latitude, context: context),
          cellDataTable(element.longitude, context: context),
          cellDataTable(element.prosena, context: context),
          cellDataTable(element.agency?.name, context: context),
          cellDataTable(element.branch?.name, context: context),
          cellDataTable(element.shiftTime?.name, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}
