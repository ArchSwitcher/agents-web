import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/schedule_modal_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/inputs/custom_checkBox_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget turnConfiguration(
    ColorScheme colorScheme, BranchController controller, bool selectMode) {
  return LayoutBuilder(builder: (context, constraints) {
    final isWideScreen = constraints.maxWidth > 750;

    final width = isWideScreen
        ? (constraints.maxWidth / 5) - 40
        : constraints.maxWidth - 40;
    return Obx(() {
      return Wrap(
        spacing: 30,
        runSpacing: 20,
        crossAxisAlignment: WrapCrossAlignment.center,
        alignment: WrapAlignment.start,
        children: [
          selectMode
              ? const SizedBox.shrink()
              : SizedBox(
                  width: width,
                  child: CustomButton(
                      color: colorScheme.primary,
                      text: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.timelapse,
                            color: colorScheme.surface,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "Agregar turno",
                            style: CustomStyle.textStyleWhite(context),
                          ),
                        ],
                      ),
                      isLoading: false,
                      onPress: () {
                        showScheduleModal(
                            context: context,
                            controller: controller,
                            onAccept: () {
                              controller.addTurn();
                              Navigator.of(context).pop();
                            });
                      })),
          // List of turn cards with index

          ...controller.turns.asMap().entries.map((entry) {
            int index = entry.key;
            var turn = entry.value;
            return turnCard(width, colorScheme, context, turn.name, controller,
                index, selectMode);
          }),
        ],
      );
    });
  });
}

Widget turnCard(double width, ColorScheme colorScheme, BuildContext context,
    String name, BranchController controller, int index, bool selectMode) {
  return SizedBox(
    width: width,
    child: Card(
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: IntrinsicHeight(
          // permite crecer en alto si es necesario
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: CustomStyle.textStyleBlack(context),
                  softWrap: true,
                ),
              ),
              selectMode
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 20,
                          padding: const EdgeInsets.all(0),
                          icon: Icon(Icons.visibility,
                              color: colorScheme.primary),
                          onPressed: () {
                            controller.selectTurn(index);
                            showScheduleModal(
                                description: "Descripción del turno",
                                isEdit: false,
                                context: context,
                                controller: controller,
                                showAcceptButton: false,
                                onAccept: () {
                                  Navigator.of(context).pop();
                                });
                          },
                        ),
                         CustomCheckbox(
                              value: controller.turns[index].isSelected.value,
                              activeColor:
                                  Theme.of(context).colorScheme.primary,
                              unSelectedColor:
                                  Theme.of(context).colorScheme.primary,
                              checkColor: Theme.of(context).colorScheme.surface,
                              onChanged: (bool? value) {
                                  controller.toggleTurnSelection(index);
                                // if (value == true) {
                                  
                                // } else {
                                //   controller.turns[index].isSelected.value = false;
                                // }
                              },
                            )
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              icon: Icon(Icons.edit_calendar_rounded,
                                  color: colorScheme.primary),
                              onPressed: () {
                                controller.selectTurn(index);
                                showScheduleModal(
                                  description: "Editar turno",
                                  context: context,
                                  controller: controller,
                                  onAccept: () {
                                    controller.editTurn(index);
                                    Navigator.of(context).pop();
                                  },
                                );
                              },
                            ),
                            IconButton(
                              iconSize: 20,
                              padding: const EdgeInsets.all(0),
                              icon: Icon(Icons.close, color: colorScheme.error),
                              onPressed: () {
                                controller.selectTurn(index);
                                showScheduleModal(
                                    description:
                                        "¿Está seguro de eliminar este turno?",
                                    isEdit: false,
                                    context: context,
                                    controller: controller,
                                    onAccept: () {
                                      controller.deleteTurn(index);
                                      Navigator.of(context).pop();
                                    });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    ),
  );
}
