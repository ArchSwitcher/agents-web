import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/models/menu_model.dart';
import 'package:agents_app/shared/constants/routes.dart';

class MenuSidebarController extends GetxController {
  var menu = <MenuGroupModel>[].obs;

  Future<void> loadMenu(String role) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (role == 'admin') {
      menu.value = [
        MenuGroupModel(label: "Clientes", children: [
          MenuItemModel(label: "Grupos", route: RouteConstants.groups, icon: Icons.group_work_outlined),
          MenuItemModel(label: "Clientes", route: RouteConstants.clients, icon: Icons.person_outline),
          MenuItemModel(label: "Agentes", route: RouteConstants.agents, icon: Icons.shield_outlined),
          MenuItemModel(label: "Sucursales", route: RouteConstants.branch, icon: Icons.business_sharp),
          MenuItemModel(label: "Posiciones", route: RouteConstants.positions, icon: Icons.location_on_outlined),
        ]),
        MenuGroupModel(label: "Recursos humanos", children: [
          MenuItemModel(label: "Empleados", route: RouteConstants.employees, icon: Icons.people_outline),
        ]),
        MenuGroupModel(label: "Agentes", children: [
          MenuItemModel(label: "Agentes", route: RouteConstants.manageAgent, icon: Icons.people_alt_outlined),
          // MenuItemModel(label: "Asistencias Generales", route: RouteConstants.employees, icon: Icons.people_outline),
        ]),
        // MenuGroupModel(label: "Inventario", children: [
        //   MenuItemModel(label: "Bodega prendas", route: RouteConstants.inventory, icon: Icons.supervisor_account_outlined),
          
        // ]),
      ];
    } else if (role == 'usuario') {
      menu.value = [
        MenuGroupModel(label: "Perfil", children: [
          MenuItemModel(label: "Mi cuenta", route: "/cuenta", icon: Icons.account_circle),
        ]),
      ];
    } else {
      menu.clear();
    }
  }
}
