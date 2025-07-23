import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/equipment/equipment_asigment_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/equipment/controllers/equipment_controller.dart';
import 'package:agents_app/views/equipment/controllers/equipment_type_controller.dart';
import 'package:agents_app/views/equipment/widgets/equipments_modal.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:agents_app/widgets/datatable/data_table_local.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EquipmentsScreen extends StatefulWidget {
  const EquipmentsScreen({super.key});

  @override
  EquipmentsScreenState createState() => EquipmentsScreenState();
}

class EquipmentsScreenState extends State<EquipmentsScreen> {
  EquipmentTypeController equipmentTypeController =
      Get.put(EquipmentTypeController());

  EquipmentController equipmentController = Get.put(EquipmentController());
  LoaderController loaderController = Get.put(LoaderController());

  Future<void> start() async {
    loaderController.show();
    await equipmentController.fetchEquipments();
    setState(() {});
    // loaderController.hide();
  }

  final tableHeaders = [
    '',
    "#",
    'Código',
    'Tipo de equipo',
    'Número de serie',
    'Cantidad',
    'Costo',
    'Moneda',
    'Es único',
    'Asignado',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      start();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSidebarLayout(
      title: 'Equipos',
      currentRoute: RouteConstants.inventory,
      userRole: 'admin',
      content: Column(
        children: [
          ContentCard(
            child: Wrap(
              spacing: 30, // espacio horizontal entre widgets
              runSpacing: 20, // espacio vertical entre líneas si se hace wrap
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.spaceBetween,
              children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    minWidth: 300,
                    maxWidth: 600,
                  ),
                  child: FilterBox(
                    elements: [],
                    handleFilteredData: (List<dynamic> data) {},
                    isLoading: false,
                    hint: "Buscar",
                    label: "Buscar",
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 200,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          showEquipmentsModal(
                            context: context,
                            equipmentTypeController: equipmentTypeController,
                            equipmentController: equipmentController,
                            onAccept: () {
                              start();
                            },
                          );
                        },
                        label: const Text("Añadir inventario"),
                        icon: const Icon(Icons.inventory),
                      ),
                    ),
                    // const SizedBox(width: 20),
                    // SizedBox(
                    //   width: 250,
                    //   child: ElevatedButton.icon(
                    //     onPressed: () {},
                    //     label: const Text("Añadir tipo inventario"),
                    //     icon: const Icon(Icons.pin_invoke_outlined),
                    //   ),
                    // ),
                  ],
                )
              ],
            ),
          ),
          cardContentSpace(),
          ContentCard(
              child: CustomPaginatedDataTableWidget(
            data: equipmentController.equipments,
            columns: tableHeaders
                .map((header) => DataColumn(label: Text(header)))
                .toList(),
            buildRows: (list) => buildTableRowsFromList(
                equipmentController.equipments, context, () {
              start();
            }),
            rowsPerPage: 100,
          ))
        ],
      ),
    );
  }
}

List<DataRow> buildTableRowsFromList(List<EquipmentModel> list,
    BuildContext context, final VoidCallback? onAccept) {
  return List.generate(list.length, (index) {
    final element = list[index];
    return DataRow(
      cells: [
        DataCell(Row(children: [
          // button for add equipment when is_unique false
          if (element.equipmentType!.isUnique == 0)
            IconButton(
              icon: const Icon(Icons.add_circle_outline),
              onPressed: () {
                showEquipmentsModal(
                    context: context,
                    equipmentTypeController:
                        Get.find<EquipmentTypeController>(),
                    equipmentController: Get.find<EquipmentController>(),
                    onAccept: () {
                      onAccept?.call();
                    });
              },
            ),
          // editEquipmentButton(context, element),
          // deleteEquipmentButton(context, element.id.toString()),
        ])),
        cellDataTable(index + 1, context: context),
        cellDataTable(element.id, context: context),
        cellDataTable(element.equipmentType!.name, context: context),
        cellDataTable(element.serialNumber, context: context),
        cellDataTable(element.quantity, context: context),
        cellDataTable(element.cost, context: context),
        cellDataTable(element.currency, context: context),
        cellDataTable(
            element.equipmentType!.isUnique == 1
                ? element.isAssigned == 1
                    ? "Si"
                    : "No"
                : "No Aplica",
            context: context),
        cellDataTable(element.equipmentType!.isUnique == 1 ? "Si" : "No",
            context: context),
      ],
      color: colorRowDataTable(index, context),
    );
  });
}
