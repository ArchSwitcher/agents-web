import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/image_picker_button.dart';
import 'package:flutter/material.dart';

void showVacationStatusModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Vacaciones del empleado",
  bool isEdit = true,
  required EmployeeAgentController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ModalVacationStatus(controller: controller),
      onAccept: () async {},
      onCancel: () {},

      title: title,
      subtitle: description,
      acceptText: "Agregar",
      cancelText: "Cerrar",
      // showAcceptButton: true,
    ),
  );
}

class ModalVacationStatus extends StatefulWidget {
  final EmployeeAgentController controller;

  const ModalVacationStatus({Key? key, required this.controller}) : super(key: key);

  @override
  _ModalVacationStatusState createState() => _ModalVacationStatusState();
}

class _ModalVacationStatusState extends State<ModalVacationStatus> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 800,
            child: ImagePickerButton(
                uploadImageController: widget.controller.vacationStatusImageController,
                text: "Vacaciones",
                validator: null),
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                    initialDate: DateTime(2025),
                    controller: widget.controller.dateVacationStatusController,
                    enabled: true,
                    label: "Fecha del curso",
                    hintText: "",
                    prefixIcon: Icons.date_range),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 400,
                child: CustomInputWidget(
                    controller: widget.controller.descriptionVacationStatusController,
                    label: "Descripción del curso",
                    hintText: "",
                    prefixIcon: Icons.description),
              )
            ],
          ),
          const Divider(),
          widget.controller.vacationStatus.isEmpty
              ? const Text("No hay cursos agregados")
              : Column(children: [
                const Text("Cursos Agregados:"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.vacationStatus.length,
                  itemBuilder: (context, index) {
                    final vacationS = widget.controller.vacationStatus[index];
                    return ListTile(
                      title: Text(vacationS.description!.value),
                      subtitle: Text(vacationS.date.toString()),
                      leading: Image.network(vacationS.documentUrl!.value,
                          width: 100, height: 100),
                    );
                  },
                )
              ]),
          const Divider()
        ],
      ),
    );
  }
}
