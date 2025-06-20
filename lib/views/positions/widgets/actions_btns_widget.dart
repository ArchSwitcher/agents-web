import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

Widget addPositionButton(BuildContext context) {
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
            "Nueva posición",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        Navigator.pushNamed(context, RouteConstants.managePosition, arguments: {
          'title': "Agregar posición",
        });
      });
}

Widget editPositionButton(BuildContext context, String branchId) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.manageBranch, arguments: {
          'title': "Editar posición",
          'branchId': branchId,
        });
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deletePositionButton(BuildContext context, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        //deleteBranchModal(context: context, branch: branch);
      },
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}
