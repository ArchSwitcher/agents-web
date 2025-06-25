import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/widgets/schedule_modal_widget.dart';
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
        Navigator.pushNamed(context, RouteConstants.manageClient);
      });
}

Widget editClient(BuildContext context, ClientModel element) {
  return IconButton(
    onPressed: () {
      Navigator.pushNamed(context, RouteConstants.manageClient, arguments: {
        'title': "Editar cliente",
        'isEdit': true,
        'subtitle': "Edita los detalles del cliente"
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

Widget openScheduleModalButton(
    BuildContext context, double width, ManageClientController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return SizedBox(
    width: width,
    child: CustomButton(
        color: colorScheme.surface,
        text: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.umbrella, color: colorScheme.primary),
            Text(
              "Cobertura",
              style: CustomStyle.textStyleBlack(context)
                  .copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        isLoading: false,
        onPress: () {
          showScheduleModal(context: context, controller: controller);
        }),
  );
}