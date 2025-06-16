import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/views/manage_client_modal.dart';
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
              _editClient(context, element, controller),
              _deleteClient(context, element, controller)
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.group.name, context: context),
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

Widget _editClient(BuildContext context, ClientModel element,
    ManageClientController controller) {
  return IconButton(
    onPressed: () {
      controller.setData(element);

      showManageClientModal(
        title: "Editar cliente",
        isEnabled: true,
        context: context,
        controller: controller,
        onAccept: () async {
          final client = ClientModel(
            id: element.id,
            name: controller.nameController.text.trim(),
            email: controller.emailController.text.trim(),
            phone: controller.phoneController.text.trim(),
            url: controller.urlController.text.trim(),
            group: Group(
                id: controller.groupId.value.id,
                name: controller.groupId.value.label),
            admin: Admin(
                id: "1", name: 'Admin'), // Assuming admin is always 1 for now
          );
          await controller.editClient(client);
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        onCancel: () {},
      );
    },
    icon: Icon(
      Icons.edit_square,
      color: Theme.of(context).colorScheme.onPrimaryFixed,
    ),
  );
}

Widget _deleteClient(BuildContext context, ClientModel element,
    ManageClientController controller) {
  return IconButton(
    onPressed: () {
      controller.setData(element);

      showManageClientModal(
        title: "Eliminar cliente",
        isEnabled: false,
        context: context,
        controller: controller,
        onAccept: () async {
         
          await controller.deleteClient(element.id.toString());
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        },
        onCancel: () {},
      );
    },
    icon: Icon(
      Icons.delete,
      color: Theme.of(context).colorScheme.error,
    ),
  );
}
