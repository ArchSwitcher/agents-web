import 'package:agents_app/views/employees/controller/manage_employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/image_picker_button.dart';
import 'package:flutter/material.dart';

void showCriminalModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Antecedentes penales del empleado",
  bool isEdit = true,
  required ManageEmployeeController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      showAcceptButton: false,
      content: ModalCriminalRecord(controller: controller),
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

class ModalCriminalRecord extends StatefulWidget {
  final ManageEmployeeController controller;

  const ModalCriminalRecord({Key? key, required this.controller}) : super(key: key);

  @override
  _ModalCriminalRecordState createState() => _ModalCriminalRecordState();
}

class _ModalCriminalRecordState extends State<ModalCriminalRecord> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 800,
            child: ImagePickerButton(
                uploadImageController: widget.controller.criminalRecordImageController,
                text: "Antecedentes penales",
                validator: null),
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                    initialDate: DateTime(2025),
                    controller: widget.controller.dateCriminalRecordController,
                    enabled: true,
                    label: "Fecha de vencimiento",
                    hintText: "",
                    prefixIcon: Icons.date_range),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 400,
                child: CustomInputWidget(
                    controller: widget.controller.descriptionCriminalRecordController,
                    label: "Observaciones",
                    hintText: "",
                    prefixIcon: Icons.description),
              )
            ],
          ),
          const Divider(),
          widget.controller.criminalRecords.isEmpty
              ? const Text("No hay antecedentes penales  agregados")
              : Column(children: [
                const Text("Antecedentes penales:"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.criminalRecords.length,
                  itemBuilder: (context, index) {
                    final criminalRecord = widget.controller.criminalRecords[index];
                    return ListTile(
                      title: Text(criminalRecord.description!.value),
                      subtitle: Text(criminalRecord.date.toString()),
                      leading: Image.network(criminalRecord.documentUrl!.value,
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
