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
          MenuItemModel(label: "Grupos", route: RouteConstants.clients, icon: Icons.person),
          MenuItemModel(label: "Clientes", route: RouteConstants.clients, icon: Icons.person),
          MenuItemModel(label: "Agentes", route: RouteConstants.agents, icon: Icons.shield),
        ]),
        MenuGroupModel(label: "Configuración", children: [
          MenuItemModel(label: "Parámetros", route: "/parametros", icon: Icons.settings),
        ]),
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
