// ignore_for_file: library_private_types_in_public_api

import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/branch/branch_index_model.dart';
// import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/branches/controller/branch_controller.dart';
import 'package:agents_app/views/branches/widgets/branch_actions_btns_widget.dart';
import 'package:agents_app/views/branches/widgets/branch_table_row_widget.dart';
// import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
// import 'package:agents_app/widgets/datatable/data_table_local.dart';
import 'package:agents_app/widgets/datatable/data_table_v3.dart';
// import 'package:agents_app/widgets/datatable/filter_box.dart';
// import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
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
  List<BranchModel> initialBranches = <BranchModel>[];

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

  bool isSearched = false;
  start() async {
    await controller.fetchBranches();
    // await controller.fetchBranchesPagination("1", "100");
    initialBranches = controller.branches;

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
    return SingleChildScrollView(
      child: Column(
        children: [
          // add new group
          ContentCard(
            child: Wrap(
              spacing: 30,
              runSpacing: 20,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.end,
              children: [
                SizedBox(
                  width: 190,
                  child: searchBranchButton(context, controller, () async {
                    await controller.searchBranches();
                    isSearched = true;
                    setState(() {});
                  }),
                ),
                if (isSearched)
                  SizedBox(
                    width: 220,
                    child: ElevatedButton.icon(
                        onPressed: () async {
                          controller.controllerSearchBranch.clear();
                          controller.controllerSearchClient.clear();
                          controller.controllerSearchGroup.clear();
                          await controller.fetchBranches();
                          isSearched = false;
                          setState(() {});
                        },
                        label: Text("Limpiar búsqueda"),
                        icon: Icon(Icons.clear)),
                  ),
                SizedBox(
                    width: 160, child: addBranchButton(context, controller)),
              ],
            ),
          ),

          // table content, edit delete elements
          cardContentSpace(),
          // ContentCard(child: Obx(() {
          //   return CustomDataTableWidgetV2(
          //       // minWidth: 2000,
          //       dynamicHeight: false,
          //       tableHeight: TableHelper.getTableHeight(controller.branches),
          //       fixedColumnWidths: fixedColumnWidths,
          //       //columnSizes: columnSizes,
          //       tableHeaders: headers,
          //       tableRows: buildTableRowsBranches(controller, context));
          // }))
          // ContentCard(
          //     child: CustomPaginatedDataTableWidget(
          //   data: controller.branches,
          //   columns: headers
          //       .map((header) => DataColumn(label: Text(header)))
          //       .toList(),
          //   buildRows: (list) => buildTableRowsBranches(controller, context),
          //   rowsPerPage: 100,
          // ))
          ContentCard(
            child: PaginatedDataTableRows(
              rows: buildTableRowsBranches(controller, context),
              columns: headers
                  .map((header) => DataColumn(label: Text(header)))
                  .toList(),
              rowsPerPage: 30,
              onPageChanged: (page) {
                print('Página actual: $page');
              },
            ),
          ),
        ],
      ),
    );
  }
}


  // ContentCard(child: Obx(() {
  //         return SizedBox(
  //           height: 500,
  //           child: PaginatedDataTableWidget(
  //             tableHeaders: headers,
  //             tableRows: buildTableRowsBranches(controller, context),
  //             fixedColumnWidths: fixedColumnWidths,
  //             // columnSizes: columnSizes,  // si usas
  //             showCheckboxColumn: false,
  //             onSort: null,
  //           ),
  //         );
  //       }))