import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/helpers/validations/not_empty.dart';
import 'package:agents_app/shared/helpers/validations/time_validatot.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_checkBox_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

void showScheduleModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  required ManageClientController controller,
  String description = "",
  String title = "Turnos",
  bool isEdit = true,
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
                    },
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
      onCancel: onCancel,
      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
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
          Expanded(
            child: CustomInputWidget(
              enabled: widget.enabled,
              controller: widget.startTimeController,
              label: "Hora de inicio",
              validator: (v) {
                if(widget.isSelected == false) return null;
                final timeError = validateTime(v);
                if (timeError != null) {
                  return timeError;
                }
                if(v == "23:59") {
                  return "Hora no valida";
                }
                return null;
              },
              keyboardType: TextInputType.datetime,
              hintText: "HH:mm",
              prefixIcon: Icons.access_time,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomInputWidget(
              enabled: widget.enabled,
              controller: widget.endTimeController,
              label: "Hora de fin",
              validator: (v) {
                if(widget.isSelected == false) return null;
                final timeError = validateTime(v);
                if (timeError != null) {
                  return timeError;
                }
                if(v == "00:00") {
                  return "Hora no valida";
                }
                return null;
              },
              keyboardType: TextInputType.datetime,
              hintText: "HH:mm",
              prefixIcon: Icons.access_time,
            ),
          ),
        ],
      ),
    );
  }
}
