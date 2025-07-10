import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:agents_app/models/menu_model.dart';
import 'package:agents_app/shared/constants/routes.dart';

class MenuSidebarController extends GetxController {
  var menu = <MenuGroupModel>[].obs;

  Future<void> loadMenu(String role) async {
    await Future.delayed(const Duration(milliseconds: 500));
    print("Cargando menú para el rol: $role");

    if (role == 'Administrador') {
      menu.value = [
        MenuGroupModel(label: "Clientes", children: [
          MenuItemModel(
              label: "Grupos",
              route: RouteConstants.groups,
              icon: Icons.group_work_outlined),
          MenuItemModel(
              label: "Clientes",
              route: RouteConstants.clients,
              icon: Icons.person_outline),
          MenuItemModel(
              label: "Agentes",
              route: RouteConstants.agents,
              icon: Icons.shield_outlined),
          MenuItemModel(
              label: "Sucursales",
              route: RouteConstants.branch,
              icon: Icons.business_sharp),
          MenuItemModel(
              label: "Posiciones",
              route: RouteConstants.positions,
              icon: Icons.location_on_outlined),
        ]),
        MenuGroupModel(label: "Recursos humanos", children: [
          MenuItemModel(
              label: "Empleados",
              route: RouteConstants.employees,
              icon: Icons.people_outline),
        ]),
        MenuGroupModel(label: "Agentes", children: [
          MenuItemModel(
              label: "Agentes",
              route: RouteConstants.manageAgent,
              icon: Icons.people_alt_outlined),
          // MenuItemModel(label: "Asistencias Generales", route: RouteConstants.employees, icon: Icons.people_outline),
        ]),
        //  MenuGroupModel(label: "Agente", children: [
        //     MenuItemModel(label: "Asistencias", route: RouteConstants.myPresence, icon: Icons.assignment_turned_in_outlined),
        //   // MenuItemModel(label: "Asistencias Generales", route: RouteConstants.employees, icon: Icons.people_outline),
        // ]),
        // MenuGroupModel(label: "Inventario", children: [
        //   MenuItemModel(label: "Bodega prendas", route: RouteConstants.inventory, icon: Icons.supervisor_account_outlined),

        // ]),
      ];
    } else if (role == 'Agente') {
      menu.value = [
        MenuGroupModel(label: "Agente", children: [
          MenuItemModel(
              label: "Asistencias",
              route: RouteConstants.myPresence,
              icon: Icons.assignment_turned_in_outlined),
          // MenuItemModel(label: "Asistencias Generales", route: RouteConstants.employees, icon: Icons.people_outline),
        ]),
      ];
    } else {
      menu.clear();
    }
  }
}
