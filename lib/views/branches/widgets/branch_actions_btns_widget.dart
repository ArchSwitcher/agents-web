import 'package:agents_app/models/branch/branch_index_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/agents/agents_detail.dart';
import 'package:agents_app/views/branches/widgets/delete_modal_widget.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/schedule_modal_widget.dart';

Widget addBranchButton(BuildContext context, BranchController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.group_add,
            color: colorScheme.onSurface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nueva sucursal",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        await Navigator.pushNamed(context, RouteConstants.manageBranch,
            arguments: {
              'title': "Agregar sucursal",
            });
        controller.fetchBranches();
      });
}

Widget editBranchButton(
    BuildContext context, BranchModel branch, BranchController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        await Navigator.pushNamed(context, RouteConstants.manageBranch,
            arguments: {
              'title': "Editar sucursal",
              'subtitle': "Editar sucursal",
              'branchId': branch.id,
              'branch': branch,
              'isEditing': true,
            });

        controller.fetchBranches();
      },
      icon: Icon(
        Icons.edit,
        color: colorScheme.onPrimary,
        size: 20,
      ));
}

Widget deleteBranchButton(BuildContext context, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () {
        deleteBranchModal(context: context, branch: branch);
      },
      icon: Icon(
        Icons.delete,
        color: colorScheme.error,
        size: 20,
      ));
}

Widget openScheduleModalButton(
    BuildContext context, double width, BranchController controller) {
  final colorScheme = Theme.of(context).colorScheme;

  return SizedBox(
    width: width,
    child: CustomButton(
        color: colorScheme.surface,
        text: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Icon(Icons.umbrella, color: colorScheme.onPrimary),
            Text(
              "Cobertura",
              style: CustomStyle.textStyleBlack(context)
                  .copyWith(color: colorScheme.primary),
            ),
          ],
        ),
        isLoading: false,
        onPress: () {
          showScheduleModal(context: context, controller: controller);
        }),
  );
}

Widget viewPositionButton(
    BuildContext context, BranchController controller, String branchId) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        await Navigator.pushNamed(context, RouteConstants.manageBranchPositions,
            arguments: {
              'title': "Posiciones de sucursal",
              'branchId': branchId,
            });
        controller.fetchBranches();
      },
      icon: Icon(
        Icons.location_on,
        color: colorScheme.onPrimary,
        size: 20,
      ));
}

// viewStayButton
Widget viewStayButton(
    BuildContext context, String branchId, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;

  return IconButton(
      onPressed: () async {
        if (branch.positions == 0) {
          ToastService.warning(
              title: "No hay posiciones",
              subTitle:
                  "La sucursal no tiene posiciones registradas para ser entregada.");
          return;
        }
        await Navigator.pushNamed(context, RouteConstants.branchPositionStay,
            arguments: {
              'title': "Estancia de sucursal",
              'branchId': branchId,
            });
      },
      icon: Icon(
        Icons.document_scanner_rounded,
        color: colorScheme.onPrimary,
        size: 20,
      ));
}

Widget searchBranchButton(
    BuildContext context, BranchController controller, VoidCallback? onAccept) {
  final colorScheme = Theme.of(context).colorScheme;
  return ElevatedButton.icon(
      label: const Text("Buscar sucursal"),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Buscar sucursal"),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomInputWidget(
                      label: "Buscar por nombre",
                      hintText: "",
                      prefixIcon: Icons.home,
                      controller: controller.controllerSearchBranch,
                    ),
                    const SizedBox(height: 10),
                    CustomInputWidget(
                      label: "Buscar por cliente",
                      hintText: "",
                      prefixIcon: Icons.business_outlined,
                      controller: controller.controllerSearchClient,
                    ),
                    const SizedBox(height: 10),
                    CustomInputWidget(
                      label: "Buscar por grupo",
                      hintText: "",
                      prefixIcon: Icons.group,
                      controller: controller.controllerSearchGroup,
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancelar"),
                  ),
                  TextButton(
                    onPressed: () {
                      onAccept?.call();
                      Navigator.of(context).pop();
                    },
                    child: Text("Buscar"),
                  ),
                ],
              );
            });
      },
      icon: Icon(
        Icons.search,
        color: colorScheme.onSurface,
        size: 20,
      ));
}


Widget viewExpedient(
    BuildContext context, String branchId, BranchModel branch) {
  final colorScheme = Theme.of(context).colorScheme;
  final positions = branch.listPositions ?? [];
  return IconButton(
    onPressed: () {
        showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Expediente de ${branch.branchName}"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ...positions.map((position) {
              final employees = position.employee ?? [];

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Posición: ${position.name}"),
                  const SizedBox(height: 5),
                  Text("Empleados:"),
                  ...employees.map((employee) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: Text("- ${employee.firstName}"),
                        ),
                        IconButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => AgentsDetail(
                                      agents: [], agentId: employee.cvh),
                                ),
                              );
                            },
                            icon: const Icon(Icons.person))
                      ],
                    );
                  }).toList(),
                  const Divider(),
                ],
              );
            }).toList(),
            // Text("ID: ${branch.id}"),
            // Text("Nombre: ${branch.name}"),
            // Text("Cliente: ${branch.clientName ?? 'N/A'}"),
            // Text("Grupo: ${branch.groupName ?? 'N/A'}"),
            // Text("Posiciones: ${branch.positions}"),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("Cerrar"),
          ),
        ],
      );
    },
  );
    },
    icon: Icon(
      Icons.folder,
      color: colorScheme.onPrimary,
      size: 20,
    ),
  );
}
