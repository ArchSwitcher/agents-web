import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
// import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/agent/controller/agent_presence_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PresencesScreen extends StatefulWidget {
  const PresencesScreen({super.key});

  @override
  PresencesScreenState createState() => PresencesScreenState();
}

class PresencesScreenState extends State<PresencesScreen> {
  final AgentPresenceController controller = Get.put(AgentPresenceController());

  final LoaderController loaderController = Get.put(LoaderController());
  final SessionController sessionController = Get.find<SessionController>();

  start() async {
    loaderController.show();
    final employeeId = sessionController.person.value.employeeId;
    await controller.fetchMyPositions(employeeId);
    loaderController.hide();
    controller.update();
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
    return ResponsiveSidebarLayout(
      title: "Mis posiciones",
      currentRoute: RouteConstants.myPresence,
      userRole: "agente",
      content: Column(
        children: [
          ContentCard(
              child: Column(children: [
            Center(
              child: Text(
                "Registro de mis posiciones.",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary),
              ),
            ),
            Obx(() => controller.positions.isEmpty
                ? const Center(
                    child: Text(
                      "Aún no tienes posiciones asignadas.",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: controller.positions.length,
                    itemBuilder: (context, index) {
                      final position = controller.positions[index];
                      final isActivePosition =
                          position.employee?[0].position?.isActive ?? false;

                      final presence = controller.findDayOfTurn(position);

                      print("objects: presence ---- $presence");
                      print("objects: position ---- ${isActivePosition}");

                      return ListTile(
                        title: Text(position.name),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                "Puesto: ${position.employee![0].position!.isPrincipal ? "Principal" : "Temporal"}"),
                            Text("Sucursal: ${position.branch?.name ?? 'N/A'}"),
                            Text("Agencia: ${position.agency?.name ?? 'N/A'}"),
                            Text(
                                "Tipo de servicio: ${position.serviceType?.name ?? 'N/A'}"),
                            Text("Fecha de inicio: ${position.initDate}"),
                            Text("Fecha de fin: ${position.endDate}"),
                            const SizedBox(height: 10),
                            // ElevatedButton.icon(
                            //     onPressed: () {},
                            //     label: Text("Ver detalles",
                            //         style: TextStyle(
                            //             color: Theme.of(context)
                            //                 .colorScheme
                            //                 .surface)),
                            //     icon: Icon(
                            //       Icons.info,
                            //       color: Theme.of(context).colorScheme.surface,
                            //     ),
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor:
                            //           Theme.of(context).colorScheme.primary,
                            //       minimumSize: const Size(190, 40),
                            //     )),
                            // !(isActivePosition && presence != null)
                            //     ? const SizedBox.shrink() :
                                 Column(
                                    children: [
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            try {
                                              showDialogPresence(
                                                  "Confirmar asistencia",
                                                  "¿Estás seguro de que deseas marcar la asistencia de esta posición?",
                                                  () async {
                                                loaderController.show();
                                                final response =
                                                    await controller
                                                        .markPresenceAsStarted(
                                                            position);

                                                if (response) {
                                                  // start();
                                                }
                                                loaderController.hide();
                                              });
                                            } catch (e) {
                                              print(
                                                  "Error marking presence: $e");
                                            } finally {
                                              print("Hiding loader");
                                              loaderController.hide();
                                            }
                                          },
                                          label: Text("Marcar asistencia",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface)),
                                          icon: Icon(
                                            Icons.check,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .primary,
                                            minimumSize: const Size(190, 40),
                                          )),
                                      const SizedBox(height: 10),
                                      ElevatedButton.icon(
                                          onPressed: () {
                                            showDialogPresence(
                                                "Confirmar salida",
                                                "¿Estás seguro de que deseas marcar la salida de esta posición?",
                                                () async {
                                              loaderController.show();
                                              await controller
                                                  .markPresenceAsEnded(
                                                      position);
                                              loaderController.hide();
                                            });
                                          },
                                          label: Text("Marcar salida",
                                              style: TextStyle(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .surface)),
                                          icon: Icon(
                                            Icons.exit_to_app,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .surface,
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Theme.of(context)
                                                .colorScheme
                                                .error,
                                            minimumSize: const Size(190, 40),
                                          )),
                                    ],
                                  )
                          ],
                        ),
                        trailing: Text(
                            "Estado: ${isActivePosition ? 'Activo' : 'Inactivo'} "),
                      );
                    },
                  )),
          ])),
        ],
      ),
    );
  }
}

// build modal to confirm presence

void showDialogPresence(
    String title, String message, void Function() onConfirm) {
  Get.dialog(
    AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text("Cancelar"),
        ),
        ElevatedButton(
          onPressed: () {
            onConfirm(); // Call the function to mark presence
            Get.back();
          },
          child: const Text("Confirmar"),
        ),
      ],
    ),
  );
}
