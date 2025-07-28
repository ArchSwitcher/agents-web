import 'package:agents_app/views/manage-agent-employees/controllers/employee_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/date_picker.dart';
import 'package:agents_app/widgets/inputs/image_picker_button.dart';
import 'package:flutter/material.dart';

void showPoliceRecordModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Antecedentes policíacos",
  bool isEdit = true,
  required EmployeeAgentController controller,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: PoliceRecordsModal(controller: controller),
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

class PoliceRecordsModal extends StatefulWidget {
  final EmployeeAgentController controller;

  const PoliceRecordsModal({Key? key, required this.controller}) : super(key: key);

  @override
  _PoliceRecordsModalState createState() => _PoliceRecordsModalState();
}

class _PoliceRecordsModalState extends State<PoliceRecordsModal> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 800,
            child: ImagePickerButton(
                uploadImageController: widget.controller.policeRecordsImageController,
                text: "Antecedentes policíacos",
                validator: null),
          ),
          Row(
            children: [
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                    initialDate: DateTime(2025),
                    controller: widget.controller.datePoliceRecordsController,
                    enabled: true,
                    label: "Fecha de vencimiento",
                    hintText: "",
                    prefixIcon: Icons.date_range),
              ),
              const SizedBox(width: 30),
              SizedBox(
                width: 400,
                child: CustomInputWidget(
                    controller: widget.controller.descriptionPoliceRecordsController,
                    label: "Observaciones",
                    hintText: "",
                    prefixIcon: Icons.description),
              )
            ],
          ),
          const Divider(),
          widget.controller.policeRecords.isEmpty
              ? const Text("No hay antecedentes policíacos agregados")
              : Column(children: [
                const Text("Antecedentes policíacos:"),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.controller.policeRecords.length,
                  itemBuilder: (context, index) {
                    final policeRecord = widget.controller.policeRecords[index];
                    return ListTile(
                      title: Text(policeRecord.description!.value),
                      subtitle: Text(policeRecord.date.toString()),
                      leading: Image.network(policeRecord.documentUrl!.value,
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
