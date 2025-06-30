import 'package:agents_app/views/branches/controller/business_controller.dart';
import 'package:agents_app/views/branches/widgets/business_modal.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';

Widget addBusinessButton(BuildContext context, BusinessController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.add_business,
            color: colorScheme.surface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nueva razón social",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        showBusinessModal(
          context: context,
          onAccept: () async {
            await controller.addBusiness();
            Navigator.of(context).pop();
            controller.clear();
            await controller.getBusinesses();
          },
          onCancel: () {},
          controller: controller,
          description: "Agregar una nueva razón social",
        );
      });
}

Widget editBusinessButton(
    BuildContext context, dynamic business, BusinessController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        controller.setBusiness(business);
        showBusinessModal(
          context: context,
          onAccept: () async {
            await controller.updateBusiness();
            Navigator.of(context).pop();
            controller.clear();
            await controller.getBusinesses();
          },
          onCancel: () {},
          controller: controller,
          description: "Editar razón social",
        );
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deleteBusinessButton(
    BuildContext context, dynamic business, BusinessController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {},
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}
