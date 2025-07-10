import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_checkBox_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

void showScheduleModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  required BranchController controller,
  String description = "",
  String title = "Turnos",
  bool isEdit = true,
  bool showAcceptButton = true,
}) {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: SingleChildScrollView(child: Obx(() {
        return Form(
          key: formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomInputWidget(
                enabled: isEdit,
                controller: controller.turnName,
                label: "Nombre turno",
                hintText: "",
                prefixIcon: Icons.label,
                validator: (value) => notEmptyFieldValidator(value),
              ),
              Column(
                children: controller.weekDays.map((day) {
                  return WeekDayTime(
                    enabled: isEdit,
                    endTimeController: day.endTimeController,
                    startTimeController: day.startTimeController,
                    weekDay: day.name,
                    isSelected: day.isSelected.value,
                    onChanged: (value) {
                      if (isEdit == false) return;
                      controller.toggleWeekDay(day);
                    }
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      })),
      onAccept: () {
        if (formKey.currentState!.validate()) {
          onAccept?.call();
        } else {
          ToastService.warning(
              title: "Error validación",
              subTitle: "Por favor, complete todos los campos requeridos.");
        }
      },
      onCancel: () {
        controller.clearTurn();
      },
      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
      showAcceptButton: showAcceptButton,
    ),
  );
}

// build a stateful widget with CustomCheckbox and two CustomInputWidgets one for start time and one for end time
class WeekDayTime extends StatefulWidget {
  final String weekDay;
  final bool isSelected;
  final void Function(bool?)? onChanged;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  // validator for start time and end time
  
  final bool enabled;
  const WeekDayTime(
      {super.key,
      required this.weekDay,
      required this.isSelected,
      required this.onChanged,
      required this.startTimeController,
      required this.endTimeController,
      
      required this.enabled});

  @override
  State<WeekDayTime> createState() => _WeekDayTimeState();
}

class _WeekDayTimeState extends State<WeekDayTime> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomCheckbox(
            text: widget.weekDay,
            value: widget.isSelected,
            onChanged: widget.onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
            unSelectedColor: Theme.of(context).colorScheme.primary,
            checkColor: Theme.of(context).colorScheme.surface,
          ),
          const SizedBox(width: 12),
          // CustomTimePicker

          SizedBox(
            width: 100,
            child: CustomTimePicker(
              initialTime: widget.startTimeController.text.isNotEmpty
                  ? TimeOfDay(
                      hour: int.parse(
                          widget.startTimeController.text.split(':')[0]),
                      minute: int.parse(
                          widget.startTimeController.text.split(':')[1]),
                    )
                  : const TimeOfDay(hour: 0, minute: 0),
              enabled: widget.enabled,
              controller: widget.startTimeController,
              label: 'Hora de inicio',
              hintText: 'Seleccione la hora',
              prefixIcon: Icons.access_time,
              // validator: widget.startTimeValidator,
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
              width: 100,
              child: CustomTimePicker(
                  initialTime: widget.endTimeController.text.isNotEmpty
                      ? TimeOfDay(
                          hour: int.parse(
                              widget.endTimeController.text.split(':')[0]),
                          minute: int.parse(
                              widget.endTimeController.text.split(':')[1]),
                        )
                      : const TimeOfDay(hour: 0, minute: 0),
                  enabled: widget.enabled,
                  controller: widget.endTimeController,
                  label: 'Hora de fin',
                  hintText: 'Seleccione la hora',
                  prefixIcon: Icons.access_time,
                  // validator: widget.endTimeValidator
                  )),
        ],
      ),
    );
  }
}
