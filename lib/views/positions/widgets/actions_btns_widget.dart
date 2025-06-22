
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/equipment_modal_widget.dart';
import 'package:agents_app/views/positions/widgets/schedule_modal_widget.dart';
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

Widget editPositionButton(BuildContext context, PositionModel position) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, RouteConstants.managePosition, arguments: {
          'title': "Editar posición para cliente",
          'position': position,
          'isEdit': true,
        });
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.primary,
        size: 20,
      ));
}

Widget deletePositionButton(BuildContext context, String positionId) {
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

Widget openScheduleModalButton(
    BuildContext context, double width, PositionController controller) {
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

Widget manageEquipmentButton(
    BuildContext context, double width, PositionController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return SizedBox(
    width: width,
    child: CustomButton(
        color: colorScheme.surface,
        text: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.security, color: colorScheme.primary),
            Text(
              "Equipo",
              style: CustomStyle.textStyleBlack(context)
                  .copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        isLoading: false,
        onPress: () {
          showEquipmentModal(context: context, controller: controller);
        }),
  );
}
