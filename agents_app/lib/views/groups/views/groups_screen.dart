import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/groups/widgets/commons.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
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
  final tableHeaders = ["", "Código", "Nombre", "Estado"];
  final List<double?> fixedColumnWidths = [120, 120, null, 120];
  final columnSizes = [ColumnSize.S, ColumnSize.S, ColumnSize.L, ColumnSize.S];


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
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [addGroup(context, controller)]),
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
