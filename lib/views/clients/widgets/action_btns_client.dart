import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';

Widget addClientButton(
    BuildContext context, ManageClientController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          const Icon(Icons.group_add),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nuevo cliente",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        await Navigator.pushNamed(context, RouteConstants.manageClient);
        controller.fetchClients();
      });
}

Widget editClient(BuildContext context, ClientModel element) {
  return IconButton(
    onPressed: () {
      print("Edit client: ${element.group!.id}");
      Navigator.pushNamed(context, RouteConstants.manageClient, arguments: {
        'title': "Editar cliente",
        'isEdit': true,
        'subtitle': "Edita los detalles del cliente",
        'client': element,
        'clientId': element.id
      });
    },
    icon: Icon(
      Icons.edit_square,
      color: Theme.of(context).colorScheme.onPrimaryFixed,
    ),
  );
}

Widget deleteClient(BuildContext context, ClientModel element) {
  return IconButton(
    onPressed: () {
      Navigator.pushNamed(context, RouteConstants.manageClient, arguments: {
        'title': "Eliminar cliente",
        'isDelete': true,
        'subtitle': "Confirma la eliminación del cliente"
      });
    },
    icon: Icon(
      Icons.delete,
      color: Theme.of(context).colorScheme.error,
    ),
  );
}

Widget searchClientsButton(BuildContext context,
    ManageClientController controller, VoidCallback? onAccept) {
  final colorScheme = Theme.of(context).colorScheme;
  return ElevatedButton.icon(
      label: const Text("Buscar Clientes"),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Buscar Clientes"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10),
                    CustomInputWidget(
                      label: "Buscar por cliente",
                      hintText: "",
                      prefixIcon: Icons.business_outlined,
                      controller: controller.controllerSearchClient,
                    ),
                    const SizedBox(height: 10),
                    CustomInputWidget(
                      label: "Buscar por grupo",
                      hintText: "",
                      prefixIcon: Icons.group,
                      controller: controller.controllerSearchGroup,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"),
                  ),
                  TextButton(
                    onPressed: () {
                      onAccept?.call();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Buscar"),
                  ),
                ],
              );
            });
      },
      icon: Icon(
        Icons.search,
        color: colorScheme.onSurface,
        size: 20,
      ));
}
