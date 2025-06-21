import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_checkBox_widget.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

void showScheduleModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  required PositionController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(
              () => Column(
                children: controller.weekDays.map((day) {
                  return WeekDayTime(
                    endTimeController: day.endTimeController,
                    startTimeController: day.startTimeController,
                    weekDay: day.name,
                    isSelected: day.isSelected.value,
                    onChanged: (value) {
                      controller.toggleWeekDay(day);
                    },
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      onAccept: onAccept,
      onCancel: onCancel,
      title: "Cobertura de horario",
      subtitle: 'Selecciona los días de la semana y las horas de inicio y fin.',
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
  const WeekDayTime(
      {super.key,
      required this.weekDay,
      required this.isSelected,
      required this.onChanged,
      required this.startTimeController,
      required this.endTimeController});

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
            value: widget.isSelected, // Updated to use isSelected
            onChanged: widget.onChanged,
            activeColor: Theme.of(context).colorScheme.primary,
            unSelectedColor: Theme.of(context).colorScheme.primary,
            checkColor: Theme.of(context).colorScheme.surface,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: CustomInputWidget(
              enabled: widget.isSelected,
              controller: widget.startTimeController,
              label: "Hora de inicio",
              validator: (v) => null, // Replace with actual validator
              keyboardType: TextInputType.datetime,
              hintText: "HH:mm",
              prefixIcon: Icons.access_time,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: CustomInputWidget(
              enabled: widget.isSelected,
              controller: widget.endTimeController,
              label: "Hora de fin",
              validator: (v) => null,
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
