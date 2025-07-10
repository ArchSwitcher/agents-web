import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/widgets/delete_modal_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/schedule_modal_widget.dart';

Widget addBranchButton(BuildContext context, BranchController controller) {
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
            "Nueva sucursal",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        await Navigator.pushNamed(context, RouteConstants.manageBranch,
            arguments: {
              'title': "Agregar sucursal",
            });
        controller.fetchBranches();
      });
}

Widget editBranchButton(
    BuildContext context, BranchModel branch, BranchController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        Navigator.pushNamed(context, RouteConstants.manageBranch, arguments: {
          'title': "Editar sucursal",
          'subtitle': "Editar sucursal",
          'branchId': branch.id,
          'branch': branch,
          'isEditing': true,
        });

        await controller.fetchBranches();
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deleteBranchButton(BuildContext context, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        deleteBranchModal(context: context, branch: branch);
      },
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}

Widget openScheduleModalButton(
    BuildContext context, double width, BranchController controller) {
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

Widget viewPositionButton(
    BuildContext context, BranchController controller, String branchId) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        await Navigator.pushNamed(context, RouteConstants.manageBranchPositions,
            arguments: {
              'title': "Posiciones de sucursal",
              'branchId': branchId,
            });
        controller.fetchBranches();
      },
      icon: Icon(
        Icons.location_on,
        color: colorScheme.primary,
        size: 20,
      ));
}

// viewStayButton
Widget viewStayButton(
    BuildContext context, String branchId, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        if (branch.positions == 0) {
          ToastService.warning(title: "No hay posiciones", subTitle: "La sucursal no tiene posiciones registradas para ser entregada.");
          return;
        }
        await Navigator.pushNamed(context, RouteConstants.branchPositionStay,
            arguments: {
              'title': "Estancia de sucursal",
              'branchId': branchId,
            });
      },
      icon: Icon(
        Icons.document_scanner_rounded,
        color: colorScheme.primary,
        size: 20,
      ));
}
