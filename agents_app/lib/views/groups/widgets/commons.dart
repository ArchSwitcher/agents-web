import 'package:agents_app/models/group/groups_model.dart';
import 'package:agents_app/shared/resources/custom_style.dart';
import 'package:agents_app/views/groups/controllers/manage_group_controller.dart';
import 'package:agents_app/views/groups/views/manage_group_modal.dart';
import 'package:agents_app/widgets/buttons/custom_button.dart';
import 'package:agents_app/widgets/datatable/common_data_table.dart';
import 'package:flutter/material.dart';

List<DataRow> buildTableRows(
    ManageGroupController controller, BuildContext context) {
  return List.generate(
    controller.groups.length,
    (index) {
      final element = controller.groups.elementAt(index);
      return DataRow(
        cells: [
          DataCell(Row(
            children: [
              _editGroup(context, element, controller),
              _deleteGroup(context, element, controller)
            ],
          )),
          cellDataTable(element.id, context: context),
          cellDataTable(element.name, context: context),
          cellDataTable(element.status == 1 ? "Activo" : "Inactivo",
              context: context),
        ],
        color: colorRowDataTable(index, context),
      );
    },
  );
}

Widget addGroup(BuildContext context, ManageGroupController controller) {
  final colorScheme = Theme.of(context).colorScheme;
  //controller.clear();
  return CustomButton(
      color: colorScheme.primary,
      text: Row(
        children: [
          Icon(
            Icons.group_add,
            color: colorScheme.surface,
          ),
          const SizedBox(
            width: 6,
          ),
          Text(
            "Nuevo Grupo",
            style: CustomStyle.textStyleWhite(context),
          )
        ],
      ),
      isLoading: false,
      onPress: () async {
        showManageGroupModal(
          title: "Agregar grupo",
          context: context,
          controller: controller,
          onAccept: () async {
            await controller.createGroup(context);
          },
          onCancel: () {},
        );
      });
}

Widget _editGroup(BuildContext context, GroupsModel element,
    ManageGroupController controller) {
  controller.setData(value: element.name, id: element.id.toString());

  return IconButton(
      onPressed: () {
        showManageGroupModal(
          title: "Editar grupo",
          context: context,
          controller: controller,
          onAccept: () async {
            await controller.createGroup(context);
          },
          onCancel: () {},
        );
      },
      icon: Icon(
        Icons.edit_square,
        color: Theme.of(context).colorScheme.onPrimaryFixed,
      ));
}

Widget _deleteGroup(BuildContext context, GroupsModel element,
    ManageGroupController controller) {
  controller.setData(value: element.name, id: element.id.toString());

  return IconButton(
      onPressed: () {
        showManageGroupModal(
          title: "Borrar Grupo",
          context: context,
          controller: controller,
          onAccept: () async {
            await controller.delete(context);
          },
          onCancel: () {},
        );
      },
      icon: Icon(
        Icons.delete,
        color: Theme.of(context).colorScheme.onError,
      ));
}
