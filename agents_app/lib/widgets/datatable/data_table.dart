
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/theme/responsive.dart';
import 'package:flutter/material.dart';

class CustomDataTable<T> extends StatelessWidget {
  final List<String> columns;
  final List<DataRow> elements;
  final bool isHeaderWidgets;
  final List<Widget> headerWidgets;

  CustomDataTable({
    required this.columns,
    required this.elements,
    this.isHeaderWidgets = false,
    this.headerWidgets = const [],
  });

  @override
  Widget build(BuildContext context) {
    Responsive responsive = Responsive.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return DataTable(
        columnSpacing: 30.0,
        dataRowMinHeight: 40,
        dataRowMaxHeight: double.infinity,
        showCheckboxColumn: false,
        headingRowHeight: responsive.hp(6),
        headingRowColor:
            WidgetStateProperty.all<Color>(colorScheme.secondary),
        columns: isHeaderWidgets
            ? List.generate(headerWidgets.length,
                (index) => DataColumn(label: headerWidgets[index]))
            : List.generate(
                columns.length,
                (index) => DataColumn(
                  label: Expanded(
                    child: Text(
                      columns[index],
                      style: CustomStyle.tableHeader(context),
                      textAlign: TextAlign.left,
                      maxLines: 2,
                    ),
                  ),
                ),
              ),
        rows: elements);
  }
}
