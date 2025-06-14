import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/models/group/groups_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/groups/widgets/commons.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  GroupsScreenState createState() => GroupsScreenState();
}

class GroupsScreenState extends State<GroupsScreen> {
  final ManageGroupController controller = Get.put(ManageGroupController());
  final loader = Get.find<LoaderController>();

  final tableHeaders = ["", "Código", "Nombre", "Estado"];
  final List<double?> fixedColumnWidths = [120, 120, null, 120];
  final columnSizes = [ColumnSize.S, ColumnSize.S, ColumnSize.L, ColumnSize.S];
  start() async {
    await Future.delayed(Duration(seconds: 1));
    await controller.fetchGroups();
    loader.hide();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loader.show();
      start();
    });
  }

  @override
  Widget build(BuildContext context) {
    double tableHeight =
        controller.groups.length > 20 ? 0.60 : controller.groups.length * 0.07;
    return ResponsiveSidebarLayout(
        title: 'Grupos',
        description: "Configuración de grupos empresariales",
        currentRoute: RouteConstants.groups,
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
                        elements: [...controller.groups],
                        handleFilteredData: (List<GroupsModel> data) {
                          controller.groups.value = data;
                        },
                        isLoading: false,
                        hint: "Buscar grupos",
                        label: "Buscar grupo",
                      ),
                    ),
                    SizedBox(
                      width: 160,
                      child: addGroup(context, controller),
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
                    tableHeight: tableHeight,
                    fixedColumnWidths: fixedColumnWidths,
                    columnSizes: columnSizes,
                    tableHeaders: tableHeaders,
                    tableRows: buildTableRows(controller, context));
              }))
            ],
          ),
        ));
  }
}
