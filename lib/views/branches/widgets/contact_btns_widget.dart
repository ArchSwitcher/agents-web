import 'package:agents_app/models/branch/contact_model.dart';
import 'package:agents_app/views/branches/controller/contact_controller.dart';
import 'package:agents_app/views/branches/widgets/contact_modal.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';

Widget addContactButton(BuildContext context, ContactController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.quick_contacts_dialer_rounded,
            color: colorScheme.surface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nuevo contacto",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        showContactModal(
          context: context,
          onAccept: () async {
            await controller.addContact();
            Navigator.of(context).pop();
            controller.clear();
            await controller.getContacts();
          },
          onCancel: () {},
          controller: controller,
          description: "Agregar un nuevo contacto",
        );
      });
}

Widget editContactButton(BuildContext context, BranchContactModel contact) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deleteContactButton(BuildContext context, BranchContactModel contact) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        // No action defined for delete contact
      },
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}
