import 'package:agents_app/models/menu_model.dart';
import 'package:agents_app/shared/constants/routes.dart';
import 'package:flutter/material.dart';
//import '../models/menu_item.dart';

class MenuProvider extends ChangeNotifier {
  List<MenuGroupModel> _menu = [];

  List<MenuGroupModel> get menu => _menu;

  Future<void> loadMenu(String role) async {
    await Future.delayed(const Duration(milliseconds: 500));

    if (role == 'admin') {
      _menu = [
        MenuGroupModel(label: "Clientes", children: [
          MenuItemModel(label: "Clientess", route: RouteConstants.clients, icon: Icons.person),
          MenuItemModel(label: "Agentes", route: RouteConstants.agents, icon: Icons.shield),
        ]),
        MenuGroupModel(label: "Configuración", children: [
          MenuItemModel(label: "Parámetros", route: "/parametros", icon: Icons.settings),
        ]),
      ];
    } else if (role == 'usuario') {
      _menu = [
        MenuGroupModel(label: "Perfil", children: [
          MenuItemModel(label: "Mi cuenta", route: "/cuenta", icon: Icons.account_circle),
        ]),
      ];
    } else {
      _menu = [];
    }

    notifyListeners();
  }
}
