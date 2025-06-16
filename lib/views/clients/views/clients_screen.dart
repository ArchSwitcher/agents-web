import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/client/clients_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/clients/controllers/client_controller.dart';
import 'package:agents_app/views/clients/widgets/add_client.dart';
import 'package:agents_app/views/clients/widgets/table_row.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  ClientsScreenState createState() => ClientsScreenState();
}

class ClientsScreenState extends State<ClientsScreen> {
  final tableHeaders = [
    "",
    "Código",
    "Grupo",
    "Nombre",
    "Correo",
    "Url",
    "Teléfono"
  ];

  final controller = Get.put(ManageClientController());

  //final List<double?> fixedColumnWidths = [120, 120, null, 120];
  //final columnSizes = [ColumnSize.S, ColumnSize.S, ColumnSize.L, ColumnSize.S];

  start() async {
    await controller.fetchClients();
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
        title: 'Clientes',
        currentRoute: RouteConstants.clients,
        userRole: 'admin',
        content: SingleChildScrollView(
          child: Column(
            children: [
              // add new group
              ContentCard(
                child: Wrap(
                  spacing: 30,
                  runSpacing: 20,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.spaceBetween,
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        minWidth: 300,
                        maxWidth: 600,
                      ),
                      child: FilterBox(
                        elements: [...controller.clients],
                        handleFilteredData: (List<ClientModel> data) {
                          controller.clients.value = data;
                        },
                        isLoading: false,
                        hint: "Buscar clientes",
                        label: "Buscar cliente",
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: addClientButton(context, controller),
                    )
                  ],
                ),
              ),

              // table content, edit delete elements
              cardContentSpace(),
              ContentCard(child: Obx(() {
                return CustomDataTableWidgetV2(
                    minWidth: 500,
                    dynamicHeight: false,
                    tableHeight: TableHelper.getTableHeight(controller.clients),
                    //fixedColumnWidths: fixedColumnWidths,
                    //columnSizes: columnSizes,
                    tableHeaders: tableHeaders,
                    tableRows: buildTableRowsClient(controller, context));
              }))
            ],
          ),
        ));
  }
}
