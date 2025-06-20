import 'package:agents_app/layout/contect_card_space.dart';
import 'package:agents_app/layout/content_card.dart';
import 'package:agents_app/layout/responsive_sidebar_layout.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:agents_app/views/positions/widgets/actions_btns_widget.dart';
import 'package:agents_app/widgets/datatable/filter_box.dart';
import 'package:flutter/material.dart';


class PositionsScreen extends StatefulWidget {
  const PositionsScreen({super.key});

  @override
  PositionsScreenState createState() => PositionsScreenState();
}

class PositionsScreenState extends State<PositionsScreen> {
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
                        hint: "Buscar grupos",
                        label: "Buscar grupo",
                      ),
                    ),
                    SizedBox(
                      width: 170,
                      child: addPositionButton(context),
                    )
                  ],
                ),
              ),

              // table content, edit delete elements
              cardContentSpace(),
              // ContentCard(child: Obx(() {
              //   return CustomDataTableWidgetV2(
              //       minWidth: 500,
              //       dynamicHeight: false,
              //       tableHeight: TableHelper.getTableHeight(controller.groups),
              //       fixedColumnWidths: fixedColumnWidths,
              //       columnSizes: columnSizes,
              //       tableHeaders: tableHeaders,
              //       tableRows: buildTableRows(controller, context));
              // }))
            ],
          ),
        ));
  }
}
