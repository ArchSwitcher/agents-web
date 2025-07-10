// ignore_for_file: library_private_types_in_public_api

import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/branch_actions_btns_widget.dart';
import 'package:agents_app/views/branches/widgets/branch_table_row_widget.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BranchesScreen extends StatefulWidget {
  const BranchesScreen({super.key});

  @override
  _BranchesScreenState createState() => _BranchesScreenState();
}

class _BranchesScreenState extends State<BranchesScreen> {
  final BranchController controller = Get.put(BranchController());
  final loader = Get.find<LoaderController>();

  final List<String> headers = [
    "",
    "Código",
    'Cliente',
    'Sucursal',
    'Latitud',
    'Longitud',
    'NIT',
    'Dirección física',
  ];
  final List<double?> fixedColumnWidths = [
    180,
    100,
    null,
    null,
    null,
    null,
    null,
    null,
  ];

  start() async {
    
    
    await controller.fetchBranches();
    
    // setState(() {});
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
    return SingleChildScrollView(
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
                    elements: [],
                    handleFilteredData: (List<dynamic> data) {
                      //controller.groups.value = data;
                    },
                    isLoading: false,
                    hint: "Buscar sucursal",
                    label: "Buscar sucursal",
                  ),
                ),
                SizedBox(
                    width: 160, child: addBranchButton(context, controller)),
              ],
            ),
          ),

          // table content, edit delete elements
          cardContentSpace(),
          ContentCard(child: Obx(() {
            return CustomDataTableWidgetV2(
                // minWidth: 2000,
                dynamicHeight: false,
                tableHeight: TableHelper.getTableHeight(controller.branches),
                fixedColumnWidths: fixedColumnWidths,
                //columnSizes: columnSizes,
                tableHeaders: headers,
                tableRows: buildTableRowsBranches(controller, context));
          }))
        ],
      ),
    );
  }
}
