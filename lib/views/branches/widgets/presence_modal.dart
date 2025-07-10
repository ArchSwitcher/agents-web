import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/views/branches/controller/presence_controller.dart';
import 'package:agents_app/widgets/commons/generic_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresenceWidget extends StatefulWidget {
  final String employeeId;
  final String positionId;

  const PresenceWidget(
      {super.key, required this.employeeId, required this.positionId});

  @override
  State<PresenceWidget> createState() => _PresenceWidgetState();
}

class _PresenceWidgetState extends State<PresenceWidget> {
  PresenceController controller =
      Get.put<PresenceController>(PresenceController());

  start() async {
    await controller.fetchPresenceData(widget.positionId, widget.employeeId);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Column(
        children: [
          ...controller.presenceList.map((presence) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: _presenceCardBuild(context, presence),
            );
          }).toList(),
        ],
      );
    });
  }
}

Widget _presenceCardBuild(BuildContext context, PresenceModel presence) {
  final colorScheme = Theme.of(context).colorScheme;

  return Card(
    elevation: 3,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 20),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              presence.day?.name ?? '-',
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
            ),
            Text(
              '${presence.employee!.firstName} ${presence.employee!.lastName}',
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
            )
          ],
        ),
        childrenPadding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        children: [
          _cardTimeInfo(
              context,
              "Información de entrada",
              presence.startTime!,
              presence.startDate!,
              presence.startLatitude!,
              presence.startLongitude!,
              Icons.directions_walk),
          Divider(
            color: colorScheme.primary.withAlpha(80),
            thickness: 2,
          ),
          _cardTimeInfo(
            context,
            "Información de salida",
            presence.endTime!,
            presence.endDate!,
            presence.startLatitude!,
            presence.startLongitude!,
            Icons.exit_to_app,
          ),
        ],
      ),
    ),
  );
}

Widget _cardTimeInfo(BuildContext context, String title, String time,
    String date, String latitude, String longitude, IconData? icon) {
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    // decoration: BoxDecoration(
    //   color: colorScheme.primary,
    //   borderRadius: BorderRadius.circular(10),
    // ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 14,
                  fontWeight: FontWeight.bold),
            ),
            Icon(
              icon,
              color: colorScheme.onSurface,
            ),
          ],
        ),
        const SizedBox(height: 5),
        Text(
          "$date - $time",
          style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        Text(
          "Latitud: $latitude",
          style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
        //longitude
        Text(
          "Longitud: $longitude",
          style: TextStyle(
              color: colorScheme.onSurface,
              fontSize: 12,
              fontWeight: FontWeight.w400),
        ),
      ],
    ),
  );
}

void showPresenceModal({
  required BuildContext context,
  bool isEnabled = false,
  required String subtitle,
  VoidCallback? onAccept,
  VoidCallback? onCancel,
  String title = 'Sucursal',
  String acceptText = 'Aceptar',
  String positionId = '11',
  String employeeId = '18',
  // String cancelText = 'Cancelar',
}) {
  // TODO: should be repalce with correct values
  
  showDialog(
    context: context,
    builder: (context) => GenericModal(
      content: PresenceWidget(
        employeeId: positionId,
        positionId: employeeId,
      ),
      onAccept: onAccept,
      subtitle: subtitle,
      onCancel: onCancel,
      title: title,
      acceptText: acceptText,
      cancelText: "Cerrar",
      showAcceptButton: false,
    ),
  );
}
