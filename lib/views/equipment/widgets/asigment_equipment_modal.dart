import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/equipment/controllers/equipment_assgiment.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showAssignmentEquipmentModal({
  required BuildContext context,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String description = "",
  String title = "Equipo asignado",
  bool isEdit = true,
  required String employeeId,
}) {
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: AsigmentEquipmentModal(employeeId: employeeId),
      onAccept: () {
        ToastService.warning(
            title: "Error validación",
            subTitle: "Por favor, complete todos los campos requeridos.");
      },
      onCancel: () {},
      title: title,
      subtitle: description,
      acceptText: "Aceptar",
      cancelText: "Cerrar",
      showAcceptButton: false,
    ),
  );
}

class AsigmentEquipmentModal extends StatefulWidget {
  final String employeeId;

  const AsigmentEquipmentModal({super.key, required this.employeeId});

  @override
  AsigmentEquipmentModalState createState() => AsigmentEquipmentModalState();
}

class AsigmentEquipmentModalState extends State<AsigmentEquipmentModal> {
  EquipmentAsigmentController controller =
      Get.put(EquipmentAsigmentController());

  start() async {
    await controller.fetchEquipmentAssignments(widget.employeeId);
    setState(() {});
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.equipmentList.map((equipment) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 8.0),
            shadowColor: Theme.of(context).colorScheme.shadow,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      equipment.equipment!.equipmentType!.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // ignore: unnecessary_null_comparison
                        equipment.serialNumber != null
                            ? Text("Serial: ${equipment.serialNumber}")
                            : const SizedBox.shrink(),
                        Text("Cantidad: ${equipment.quantity}"),
                        Text("Notas: ${equipment.notes ?? 'Sin notas'}"),
                      ],
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        // Acción del botón
                      },
                      icon: const Icon(Icons.repeat_rounded),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
