import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';
import 'package:agents_app/models/position/position_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/branches/controller/branch_position_controller.dart';
import 'package:agents_app/views/branches/widgets/presence_modal.dart';
import 'package:agents_app/views/branches/widgets/replace_employee_position.dart';
import 'package:agents_app/views/manage-agent-employees/widgets/position_modal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchPositionsScreen extends StatefulWidget {
  const BranchPositionsScreen({super.key});

  @override
  BranchPositionsScreenState createState() => BranchPositionsScreenState();
}

class BranchPositionsScreenState extends State<BranchPositionsScreen> {
  final BranchPositionController controller =
      Get.put<BranchPositionController>(BranchPositionController());

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.fetchPositions();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = Theme.of(context).colorScheme;
    return ResponsiveSidebarLayout(
        title: "Posiciones de Sucursal",
        description: "Gestión de posiciones de sucursal",
        currentRoute: RouteConstants.branch,
        userRole: "admin",
        showBackButton: true,
        content: Center(
          heightFactor: 1.3,
          // padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: LayoutBuilder(builder: (context, constraints) {
              final isWideScreen = constraints.maxWidth > 600;
              // final width = isWideScreen
              //     ? (constraints.maxWidth / 5) - 40
              //     : constraints.maxWidth - 40;
              return Obx(() {
                return Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  direction: isWideScreen ? Axis.horizontal : Axis.vertical,
                  children: [
                    // ContendCard box decoration
                    ...controller.positions.map((position) {
                      return _positionCardBuild(context, isWideScreen,
                          constraints, position, controller);
                      // ignore: unnecessary_to_list_in_spreads
                    }).toList(),
                  ],
                );
              });
            }),
          ),
        ));
  }
}

Widget _positionCardBuild(
    BuildContext context,
    bool isWideScreen,
    BoxConstraints constraints,
    PositionModel? position,
    BranchPositionController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
    width: isWideScreen ? 550 : constraints.maxWidth - 40,
    // height: isWideScreen ? 300 : constraints.maxHeight - 40,
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: colorScheme.surface,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: colorScheme.onSurface.withOpacity(0.1),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: colorScheme.onSurface.withOpacity(0.2),
          spreadRadius: 1,
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ],
    ),
    child: Column(
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          position?.name ?? '-',
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        _employeePosition(position?.employee),
        const SizedBox(height: 10),
        _turn(context, position?.turn),
        const SizedBox(height: 10),
        _buttonsActions(
            context, position, isWideScreen, position?.turn, controller),
      ],
    ),
  );
}

Widget _turn(BuildContext context, TurnModel? turn) {
  final ColorScheme colorScheme = Theme.of(context).colorScheme;
  return SingleChildScrollView(
    scrollDirection: Axis.horizontal,
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          turn != null && turn.name.isNotEmpty
              ? "Turno: ${turn.name}"
              : "No hay turno asignado",
          style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w200,
              color: turn != null && turn.name.isNotEmpty
                  ? Theme.of(context).colorScheme.onPrimary
                  : Colors.red),
        ),
        const SizedBox(height: 5),
        turn?.schedule == null
            ? const SizedBox(
                height: 70,
              )
            : Row(
                children: [
                  ...turn!.schedule.map((schedule) {
                    return Card(
                      color: colorScheme.primary,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Text(
                              schedule.day!.name,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "${schedule.initTime} - ${schedule.endTime}",
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ],
              )
      ],
    ),
  );
}

Widget _employeePosition(List<EmployeeModel>? employees) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      ...employees!
          .where((employee) => employee.position!.isActive == true)
          .map((employee) {
        return Text(
          "${employee.firstName.toString().trim()} ${employee.lastName.toString().trim()} - ${employee.position!.isPrincipal ? 'Principal' : 'Temporal'} ${employee.position!.isActive ? "Activo" : "Inactivo"} ",
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        );
      }).toList(),
    ],
  );
}

Widget _buttonsActions(BuildContext context, PositionModel? position,
    bool isWideScreen, TurnModel? turn, BranchPositionController controller) {
  // final colorScheme = Theme.of(context).colorScheme;
  bool isEnabled = !(turn == null);

  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      ElevatedButton.icon(
          onPressed: () {
            showPositionModal(context: context, position: position);
          },
          icon: const Icon(Icons.manage_accounts, size: 20),
          label: const Text("Posición",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      const SizedBox(width: 10),
      ElevatedButton.icon(
          onPressed: isEnabled
              ? () {
                  // final employeeId = position?.employee?[0].id;
                  final employeeMap =
                      position?.employee?.map((e) => e.id).toList();
                  // print("Employee IDs: $employeeMap");
                  final positionId = position?.id;
                  // print(
                  //     "objects: employeeId: $employeeId, positionId: $positionId ------------------");
                  // TODO: deberia de mostrar las inasistencias de la posición
                  showPresenceModal(
                      context: context,
                      title: "Asistencia",
                      subtitle: "Asistencias de la posición",
                      isEnabled: isEnabled,
                      positionId: positionId!,
                      employeeIds: employeeMap!.whereType<String>().toList(),
                      onAccept: () {
                        // Handle acceptance logic here
                        // Navigator.of(context).pop();
                      });
                }
              : null,
          icon: const Icon(Icons.access_time, size: 20),
          label: const Text("Asistencia",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      const SizedBox(width: 10),
      ElevatedButton.icon(
          onPressed: isEnabled
              ? () {
                  final oldEmployeeId = position?.employee?.firstWhere(
                      (employee) => employee.position!.isActive == true);

                  showReplaceModal(
                    oldEmployeeId: oldEmployeeId?.id,
                    title: "Reemplazo de empleado",
                    context: context,
                    subtitle: "Reemplazo temporal de empleado en la posición",
                    positionId: position!.id!,
                    onAccept: () async {
                      await controller.fetchPositions();
                    },
                  );
                }
              : null,
          icon: const Icon(Icons.published_with_changes_rounded, size: 20),
          label: const Text("Remplazo",
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
    ],
  );
}
