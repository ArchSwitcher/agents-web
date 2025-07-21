import "dart:convert";
import "package:agents_app/widgets/inputs/custom_input_widget.dart";
import "package:flutter/material.dart";

class FilterBox<T> extends StatefulWidget {
  // final TextEditingController filterBoxController;
  final List<T> elements;
  final Function(List<T>) handleFilteredData;
  final bool isLoading;
  final String hint;
  final String label;
  final VoidCallback? cleanValue;

  const FilterBox(
      {super.key,
      required this.elements,
      required this.handleFilteredData,
      required this.isLoading,
      required this.hint,
      required this.label,
      this.cleanValue});

  @override
  State<FilterBox<T>> createState() => _FilterBoxState<T>();
}

class _FilterBoxState<T> extends State<FilterBox<T>> {
  final TextEditingController filterBoxController = TextEditingController();

  List<T> data = [];
  List<T> filteredData = [];
  bool hasUpdate = false;

  // @override
  // void didUpdateWidget(FilterBox<T> oldWidget) {
  //   if (widget.elements.length > 0 && !hasUpdate) {
  //     data = widget.elements;
  //     hasUpdate = true;
  //   } else if (data.length != widget.elements.length) {
  //     hasUpdate = false;
  //     // filterBoxController.clear();
  //   }

  //   super.didUpdateWidget(oldWidget);
  // }

  filterByText() {
    print("filterByText: ${filterBoxController.text}");
    if (filterBoxController.text.isEmpty) {
      widget.cleanValue?.call();
      return;
    }
    List<T> suggestions = data.where((element) {
      // encode depends on toJson method in each model, be aware of field do you want to include in the search,
      // enhanced should be included in json.encode(element, functionToEncodable) to search another method to handle de values passed.
      final quote = json.encode(element).toLowerCase();
      return quote.contains(filterBoxController.text.toLowerCase());
    }).toList();

    print("suggestions: ${suggestions.length}");
    widget.handleFilteredData(suggestions);
  }

  @override
  void initState() {
    super.initState();
    filterBoxController.addListener(() => filterByText());
     data = widget.elements;
  }

  @override
  Widget build(BuildContext context) {
    // filterBoxController.addListener(() => filterByText());

    return CustomInputWidget(
      controller: filterBoxController,
      label: widget.label,
      hintText: widget.hint,
      prefixIcon: Icons.search,
      readOnly: widget.isLoading,
      suffixIcon: IconButton(
        onPressed: () {
          // filterBoxController.clear();
          // widget.handleFilteredData(data);
          // widget.cleanValue?.call();
          // filterBoxController
          //     .removeListener(filterByText); // Detener temporalmente
          filterBoxController.text = "";
          // widget.handleFilteredData(data);
          // filterBoxController.addListener(filterByText); // Volver a añadir
          widget.cleanValue?.call();
        },
        icon: const Icon(
          Icons.close,
          color: Colors.white,
        ),
      ),
    );
  }
}

// abstract class DataToFilter {
//   Map<String, dynamic> toJson();
// }
