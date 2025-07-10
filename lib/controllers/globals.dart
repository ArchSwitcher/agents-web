import 'package:agents_app/controllers/sidebar/menu_sidebar_controller.dart';
import 'package:agents_app/models/session_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SessionController extends GetxController {
  // Variables observables
  var username = ''.obs;
  var token = ''.obs;
  var userId = 0.obs;
  var role = RoleModel(id: 0, name: '').obs; // Asumiendo que RoleModel tiene un constructor
  var person = PersonModel(id: 0, firstName: '', lastName: '').obs;

  // Métodos para setear los valores
  void setUsername(String value) {
    username.value = value;
  }

  void setToken(String value) {
    token.value = value;
  }

  void setUserId(int id) {
    userId.value = id;
  }

  // Método para establecer todo junto (por ejemplo, al hacer login)
  void setSession({required String username, required String token, required int userId, required RoleModel role, required PersonModel person}) {
    this.username.value = username;
    this.token.value = token;
    this.userId.value = userId;
    this.role.value = role;
    this.person.value = person;
  }

  // Métodos para acceder si quieres usar sin `.value`
  String get getUsername => username.value;
  String get getToken => token.value;
  int get getUserId => userId.value;
  RoleModel get getRole => role.value;
  PersonModel get getPerson => person.value;

  logOut() {
    // Aquí puedes limpiar las variables o hacer cualquier otra acción necesaria al cerrar sesión
    username.value = '';
    token.value = '';
    userId.value = 0;
    role.value = RoleModel(id: 0, name: '');
    person.value = PersonModel(id: 0, firstName: '', lastName: '');

    MenuSidebarController menuController = Get.find();
    menuController.menu.clear();
  }
}