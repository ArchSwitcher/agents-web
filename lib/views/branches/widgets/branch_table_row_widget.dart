import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/branch_actions_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';

List<DataRow> buildTableRowsBranches(
    BranchController controller, BuildContext context) {
  return List.generate(
    controller.branches.length,
    (index) {
      final BranchModel element = controller.branches.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              editBranchButton(context, element, controller),
              deleteBranchButton(context, element),
              viewPositionButton(context, controller, element.id),
              viewStayButton(context, element.id, element),
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.client?.name, context: context),
          cellDataTable(element.branchName, context: context),
          cellDataTable(element.latitude, context: context),
          cellDataTable(element.longitude, context: context),
          cellDataTable(element.nit, context: context),
          cellDataTable(element.businessAddress?.address, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}
