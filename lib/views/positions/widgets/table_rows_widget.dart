

import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';

List<DataRow> buildTableRows(
    PositionController controller, BuildContext context) {
  return List.generate(
    controller.positions.length,
    (index) {
      final PositionModel element = controller.positions.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              editPositionButton(context, element),
              deletePositionButton(context, element.id.toString()),
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
