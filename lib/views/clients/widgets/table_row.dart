import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/widgets/action_btns_client.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';

List<DataRow> buildTableRowsClient(
    ManageClientController controller, BuildContext context) {
  return List.generate(
    controller.clients.length,
    (index) {
      final ClientModel element = controller.clients.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              editClient(context, element),
              deleteClient(context, element)
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.group!.name, context: context),
          cellDataTable(element.name, context: context),
          cellDataTable(element.email, context: context),
          cellDataTable(element.url, context: context),
          cellDataTable(element.phone, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}

