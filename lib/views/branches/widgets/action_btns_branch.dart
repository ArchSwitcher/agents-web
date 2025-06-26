

import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/schedule_modal_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';

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