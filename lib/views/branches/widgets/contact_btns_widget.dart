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

Widget editContactButton(BuildContext context, BranchContactModel contact,
    ContactController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        controller.setContact(contact);
        showContactModal(
          context: context,
          onAccept: () async {
            await controller.updateContact();
            Navigator.of(context).pop();
            controller.clear();
            await controller.getContacts();
          },
          onCancel: () {},
          controller: controller,
          description: "Editar contacto",
        );
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deleteContactButton(BuildContext context, BranchContactModel contact,
    ContactController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        controller.setContact(contact);
        showContactModal(
          isEdit: false,
          context: context,
          onAccept: () async {
            await controller.deleteContact(contact.id);
            Navigator.of(context).pop();
            controller.clear();
            await controller.getContacts();
          },
          onCancel: () {},
          controller: controller,
          description: "¿Está seguro de eliminar el contacto?",
        );
      },
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}
