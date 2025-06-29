import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';

class CustomDataTableWidgetV2 extends StatelessWidget {
  final List<String> tableHeaders;
  final List<DataRow> tableRows;
  final List<ColumnSize>? columnSizes;
  final List<double?>? fixedColumnWidths;
  final double tableWidth;
  final double tableHeight;
  final double minWidth;
  final bool quitHorizontal;
  final bool dynamicHeight;
  final bool showCheckboxColumn;
  final void Function(int, bool)? onSort;
  final ScrollController verticalScrollController = ScrollController();
  final ScrollController horizontalScrollController = ScrollController();

  CustomDataTableWidgetV2({
    super.key,
    required this.tableHeaders,
    required this.tableRows,
    this.tableWidth = 1,
    this.tableHeight = 0.60,
    this.minWidth = 1350.0,
    this.quitHorizontal = false,
    this.dynamicHeight = false,
    this.columnSizes,
    this.fixedColumnWidths,
    this.showCheckboxColumn = false,
    this.onSort,
  }) : assert(
          (columnSizes != null
                  ? tableHeaders.length == columnSizes.length
                  : true) &&
              (fixedColumnWidths != null
                  ? tableHeaders.length == fixedColumnWidths.length
                  : true),
        );

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: dynamicHeight ? double.infinity : size.height * tableHeight,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return DataTable2(
            isHorizontalScrollBarVisible: true,
            columnSpacing: 12,
            horizontalMargin: 12,
            minWidth: minWidth,
            dividerThickness: 0,
            showCheckboxColumn: showCheckboxColumn,
            headingRowHeight: size.height * (0.06),
            headingRowColor:
                WidgetStateProperty.all(Theme.of(context).colorScheme.surface),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              border: Border.all(
                color: Theme.of(context).colorScheme.surface,
              ),
            ),
            lmRatio: 1.5,
            columns: _buildColumns(constraints, context),
            rows: _buildRows(),
          );
        },
      ),
    );
  }

  List<DataColumn> _buildColumns(BoxConstraints size, BuildContext context) {
    double fontSize = (size.maxWidth * 0.02).clamp(13, 18);
    return List.generate(tableHeaders.length, (index) {
      ColumnSize columnSize = columnSizes != null && index < columnSizes!.length
          ? columnSizes![index]
          : ColumnSize.M;

      double? fixedWidth =
          fixedColumnWidths != null && index < fixedColumnWidths!.length
              ? fixedColumnWidths![index]
              : null;

      return DataColumn2(
        onSort: onSort,
        label: Text(
          tableHeaders[index],
          style: CustomStyle.tableHeader(context, fontSize),
          textAlign: TextAlign.left,
          maxLines: 2,
        ),
        size: columnSize,
        fixedWidth: fixedWidth,
      );
    });
  }

  List<DataRow> _buildRows() {
    if (tableRows.isNotEmpty) {
      return tableRows;
    }
    return [
      DataRow(
        cells: List.generate(
          tableHeaders.length,
          (index) => DataCell(
            Text(index == 0 ? 'No hay información disponible' : ''),
          ),
        ),
      ),
    ];
  }
}
