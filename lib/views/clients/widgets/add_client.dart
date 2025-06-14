import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/views/manage_client_modal.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Widget addClientButton(BuildContext context, ManageClientController controller) {
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
        //controller.clear();
        showManageClientModal(
          isEnabled: true,
          title: "Agregar cliente",
          context: context,
          controller: controller,
          onAccept: () async {
            //await controller.createGroup(context);
          },
          onCancel: () {},
        );
      });
}
