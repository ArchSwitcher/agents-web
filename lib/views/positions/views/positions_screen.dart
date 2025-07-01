import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/positions/controllers/position_controller.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/views/positions/widgets/table_rows_widget.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PositionsScreen extends StatefulWidget {
  const PositionsScreen({super.key});

  @override
  PositionsScreenState createState() => PositionsScreenState();
}

class PositionsScreenState extends State<PositionsScreen> {
  final PositionController controller =
      Get.put<PositionController>(PositionController());
  final LoaderController loaderController = Get.find<LoaderController>();

  final List<String> headers = [
    "",
    'Código',
    'Nombre',
    'Latitud',
    'Longitud',
    "proseña",
    "Agencia",
    "Sucursal",
    "Horario"
  ];

  start() async {
    loaderController.show();
    await controller.fetchPositions();
    loaderController.hide();
    await controller.genericListController.getAllStatusType();
    setState(() {});
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
    return ResponsiveSidebarLayout(
        title: "Posiciones",
        description: "Configuración de posiciones para clientes",
        currentRoute: RouteConstants.positions,
        userRole: 'admin',
        content: SingleChildScrollView(
          child: Column(
            children: [
              // add new group
              ContentCard(
                child: Wrap(
                  spacing: 30, // espacio horizontal entre widgets
                  runSpacing:
                      20, // espacio vertical entre líneas si se hace wrap
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

                    // Dropdown for filtering by status type
                    LoadingAutocompleteDropdown(
                      prefixIcon: Icons.filter_alt,
                      enabled: true,
                      isLoading:
                          controller.genericListController.isLoadingStatusType,
                      listItems: controller.genericListController.statusTypes,
                      onSelected: (DropDownOption option) {
                        controller.statusType.value = option;
                        
                      },
                      label: "Filtrar por estado",
                      hintText: "seleccione un estado",
                      resetValue: controller.statusType,
                      width: 300,
                      onTextChange: (text) async {
                        List<DropDownOption> filteredOptions = controller
                            .genericListController.statusTypes
                            .where((option) => option.label
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                        return filteredOptions.isEmpty ? [] : filteredOptions;
                      },
                    ),

                    SizedBox(
                      width: 170,
                      child: addPositionButton(context),
                    ),
                    ElevatedButton(onPressed: () async{
                      await start();

                    }, child: Text("actualizar")),
                  ],
                ),
              ),

              // table content, edit delete elements
              cardContentSpace(),

              ContentCard(child: Obx(() {
                return CustomDataTableWidgetV2(
                    minWidth: 1680,
                    dynamicHeight: false,
                    tableHeight:
                        TableHelper.getTableHeight(controller.positions),
                    // fixedColumnWidths: fixedColumnWidths,
                    // columnSizes: columnSizes,
                    tableHeaders: headers,
                    tableRows: buildTableRows(controller, context));
              }))
            ],
          ),
        ));
  }
}
