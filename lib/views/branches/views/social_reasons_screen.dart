import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/branch/business_model.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/branches/controller/business_controller.dart';
import 'package:agents_app/views/branches/widgets/business_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SocialReasonsScreen extends StatefulWidget {
  const SocialReasonsScreen({ super.key });

  @override
  SocialReasonsScreenState createState() => SocialReasonsScreenState();
}

class SocialReasonsScreenState extends State<SocialReasonsScreen> {
  final BusinessController controller = Get.put(BusinessController());

  final headers = [
    "Acciones",
    "ID",
    "Nombre",
    "Actividad",
    "Sucursal",
  ];
  final List<double?> fixedColumnWidths = [100, 80, null, null, null];

  start() async{
    await controller.getBusinesses();
    controller.genericListController.getAllBranchesDd();
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
                    elements: [...controller.business],
                    handleFilteredData: (List<BranchBusinessModel> data) {
                      controller.business.value = data;
                    },
                    isLoading: false,
                    hint: "Buscar contacto",
                    label: "Buscar contacto",
                  ),
                ),
                SizedBox(width: 180, child: addBusinessButton(context, controller)),
              ],
            ),
          ),

          // table content, edit delete elements
          cardContentSpace(),
          ContentCard(child: Obx(() {
            return CustomDataTableWidgetV2(
                minWidth: 700,
                dynamicHeight: false,
                tableHeight: TableHelper.getTableHeight(controller.business),
                fixedColumnWidths: [...fixedColumnWidths],
                tableHeaders: headers,
                tableRows: buildTableRows(context, controller));
          }))
        ],
      ),
    );
  }
}


List<DataRow> buildTableRows(
    BuildContext context, BusinessController controller) {
  return List.generate(
    controller.business.length,
    (index) {
      final BranchBusinessModel element = controller.business.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              editBusinessButton(context, element,controller),
              deleteBusinessButton(context, element,controller),
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.businessName, context: context),
          cellDataTable(element.businessActivity, context: context),
          cellDataTable(element.branch?.name, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}
