import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
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
  required ManageEmployeeController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      showAcceptButton: false,
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
  final ManageEmployeeController controller;

  const ModalVacationStatus({Key? key, required this.controller})
      : super(key: key);

  @override
  _ModalVacationStatusState createState() => _ModalVacationStatusState();
}

class _ModalVacationStatusState extends State<ModalVacationStatus> {
  @override
  void initState() {
    print(
        "ModalVacationStatus created ${widget.controller.vacationStatus.length} items");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  controller:
                      widget.controller.descriptionVacationStatusController,
                  label: "Descripción del curso",
                  hintText: "",
                  prefixIcon: Icons.description),
            )
          ],
        ),
        const Divider(),
        widget.controller.vacationStatus.isEmpty
            ? const Text("No hay cursos agregados")
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Estado de vacaciones:"),
                  const SizedBox(height: 8),
                  ...widget.controller.vacationStatus
                      .map((vacationS) => Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Column(
                              children: [
                                ListTile(
                                  title:
                                      Text(vacationS.description?.value ?? ''),
                                  subtitle: Text(vacationS.date?.value ?? ''),
                                  trailing: Image.network(
                                    "https://elebano-bkt.s3.amazonaws.com/vacation_status/f364954f-0ed8-4b6e-91fb-a529d92e0111",
                                    width: 200,
                                    height: 200,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            const Icon(Icons.broken_image),
                                  ),
                                ),
                              ],
                            ),
                          )),
                ],
              ),
        const Divider()
      ],
    );
  }
}
