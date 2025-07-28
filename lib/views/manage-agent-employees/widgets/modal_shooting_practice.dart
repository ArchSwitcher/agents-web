import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/image_picker_button.dart';
import 'package:flutter/material.dart';

void showShootingPracticesModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Practica de tiro del empleado",
  bool isEdit = true,
  required EmployeeAgentController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: ModalShootingPractice(controller: controller),
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

class ModalShootingPractice extends StatefulWidget {
  final EmployeeAgentController controller;

  const ModalShootingPractice({Key? key, required this.controller}) : super(key: key);

  @override
  _ModalShootingPracticeState createState() => _ModalShootingPracticeState();
}

class _ModalShootingPracticeState extends State<ModalShootingPractice> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 800,
            child: ImagePickerButton(
                uploadImageController: widget.controller.shootingPracticeImageController,
                text: "Practica de tiro",
                validator: null),
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                    initialDate: DateTime(2025),
                    controller: widget.controller.dateShootingPracticeController,
                    enabled: true,
                    label: "Fecha de practica",
                    hintText: "",
                    prefixIcon: Icons.date_range),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 400,
                child: CustomInputWidget(
                    controller: widget.controller.descriptionShootingPracticeController,
                    label: "Observaciones",
                    hintText: "",
                    prefixIcon: Icons.description),
              )
            ],
          ),
          const Divider(),
          widget.controller.shootingPractices.isEmpty
              ? const Text("No hay practicas de tiro agregadas")
              : Column(children: [
                const Text("Practicas de tiro:"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.shootingPractices.length,
                  itemBuilder: (context, index) {
                    final shootingPractice = widget.controller.shootingPractices[index];
                    return ListTile(
                      title: Text(shootingPractice.description!.value),
                      subtitle: Text(shootingPractice.date.toString()),
                      leading: Image.network(shootingPractice.documentUrl!.value,
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
