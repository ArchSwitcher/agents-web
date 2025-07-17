import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Widget addClientButton(
    BuildContext context, ManageClientController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.group_add,
            color: colorScheme.surface,
          ),
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

