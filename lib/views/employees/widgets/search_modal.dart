import 'package:agents_app/models/common/dropdown_option_model.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:agents_app/views/employees/controller/employee_controller.dart';
import 'package:agents_app/widgets/inputs/custom_input_widget.dart';
import 'package:agents_app/widgets/inputs/dropdown_widget.dart';
import 'package:flutter/material.dart';

Widget searchEmployeeButton(BuildContext context, EmployeeController controller,
    VoidCallback? onAccept) {
  final colorScheme = Theme.of(context).colorScheme;
  return ElevatedButton.icon(
      label: const Text("Buscar empleado"),
      onPressed: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Buscar Empleado"),
                content: SearchModal(controller: controller),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Cerrar"),
                  ),
                  TextButton(
                    onPressed: () {
                      if(controller.searchNameController.text.isEmpty &&
                         controller.ddEmployeeStatus.value.id.isEmpty) {
                       ToastService.warning(title: "Búsqueda", subTitle: "Por favor, ingrese un nombre o seleccione un estado.");
                        return;
                      }

                      onAccept?.call();
                      Navigator.of(context).pop();
                    },
                    child: const Text("Buscar"),
                  ),
                ],
              );
            });
      },
      icon: Icon(
        Icons.search,
        color: colorScheme.onSurface,
        size: 20,
      ));
}

class SearchModal extends StatefulWidget {
  final EmployeeController controller;
  const SearchModal({super.key, required this.controller});

  @override
  SearchModalState createState() => SearchModalState();
}

class SearchModalState extends State<SearchModal> {
   start() async {
    await widget.controller.genericListController.fetchWorkerStatus();
    setState(() {});
  }

  @override
  void initState() {
    widget.controller.ddEmployeeStatus.value = DropDownOption(id: '', label: '');
    start();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomInputWidget(
          label: "Buscar por nombre",
          hintText: "",
          prefixIcon: Icons.person,
          controller: widget.controller.searchNameController,
        ),
        LoadingAutocompleteDropdown(
          // initialValue: widget.controller.genericListwidget.Controller.isLoadingWorkerStatus
          prefixIcon: Icons.change_circle_sharp,
          enabled: true,
          isLoading:
              widget.controller.genericListController.isLoadingWorkerStatus,
          listItems:
              widget.controller.genericListController.workerStatus.toList(),
          onSelected: (DropDownOption option) {
            widget.controller.ddEmployeeStatus.value = option;
          },
          label: "Estado del empleado",
          hintText: "",
          resetValue: widget.controller.ddEmployeeStatus,
          width: double.infinity,
          onTextChange: (text) async {
            List<DropDownOption> filteredOptions = widget.controller
                .genericListController.workerStatus
                .where((option) =>
                    option.label.toLowerCase().contains(text.toLowerCase()))
                .toList();
            return filteredOptions.isEmpty ? [] : filteredOptions;
          },
        ),
        // const SizedBox(height: 10),
        // CustomInputWidget(
        //   label: "Buscar por cliente",
        //   hintText: "",
        //   prefixIcon: Icons.business_outlined,
        //   controller: widget.controller.controllerSearchClient,
        // ),
        // const SizedBox(height: 10),
        // CustomInputWidget(
        //   label: "Buscar por grupo",
        //   hintText: "",
        //   prefixIcon: Icons.group,
        //   controller: widget.controller.controllerSearchGroup,
        // ),
      ],
    );
  }
}
