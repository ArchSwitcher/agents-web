import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/widgets/delete_modal_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Widget addBranchButton(BuildContext context) {
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
        Navigator.pushNamed(context, RouteConstants.manageBranch, arguments: {
          'title': "Agregar sucursal",
        });
      });
}

Widget editBranchButton(BuildContext context, String branchId) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.edit,
            color: colorScheme.surface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Editar sucursal",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        Navigator.pushNamed(context, RouteConstants.manageBranch, arguments: {
          'title': "Editar sucursal",
          'branchId': branchId,
        });
      });
}

Widget deleteBranchButton(BuildContext context, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.error,
      text: Row(
        children: [
          Icon(
            Icons.delete,
            color: colorScheme.surface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Eliminar sucursal",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        deleteBranchModal(context: context, branch: branch);
      });
}
