import 'package:agents_app/controllers/loader_controller.dart';
import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/models/branch/contact_model.dart';
import 'package:agents_app/shared/helpers/table/index.dart';
import 'package:agents_app/views/branches/controller/contact_controller.dart';
import 'package:agents_app/views/branches/widgets/contact_btns_widget.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:agents_app/widgets/datatable/custom_data_table_widget_v2.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContactsScreen extends StatefulWidget {
  const ContactsScreen({super.key});

  @override
  State<ContactsScreen> createState() => _ContactsScreenState();
}

class _ContactsScreenState extends State<ContactsScreen> {
  final ContactController controller = Get.put(ContactController());
  final loader = Get.find<LoaderController>();

  final List<String> headers = ["", 'Código', 'Nombre', 'Teléfono', 'Sucursal'];
  final List<double?> fixedColumnWidths = [100, 80, null, null, null];

  start() async {
    loader.show();
    await controller.getContacts();
    await controller.genericListController.getAllBranchesDd();
    loader.hide();
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
                    elements: [...controller.contacts],
                    handleFilteredData: (List<BranchContactModel> data) {
                      controller.contacts.value = data;
                    },
                    isLoading: false,
                    hint: "Buscar contacto",
                    label: "Buscar contacto",
                  ),
                ),
                SizedBox(width: 160, child: addContactButton(context, controller)),
              ],
            ),
          ),

          // table content, edit delete elements
          cardContentSpace(),
          ContentCard(child: Obx(() {
            return CustomDataTableWidgetV2(
                minWidth: 700,
                dynamicHeight: false,
                tableHeight: TableHelper.getTableHeight(controller.contacts),
                fixedColumnWidths: fixedColumnWidths,
                //columnSizes: columnSizes,
                tableHeaders: headers,
                tableRows: buildTableRows(context, controller));
          }))
        ],
      ),
    );
  }
}

List<DataRow> buildTableRows(
    BuildContext context, ContactController controller) {
  return List.generate(
    controller.contacts.length,
    (index) {
      final BranchContactModel element = controller.contacts.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              editContactButton(context, element),
              deleteContactButton(context, element),
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.name, context: context),
          cellDataTable(element.phone, context: context),
          cellDataTable(element.branch?.name, context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}
