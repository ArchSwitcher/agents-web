import 'package:get/get.dart';

class SessionController extends GetxController {
  // Variables observables
  var username = ''.obs;
  var token = ''.obs;
  var userId = 0.obs;

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
  void setSession({required String username, required String token, required int userId}) {
    this.username.value = username;
    this.token.value = token;
    this.userId.value = userId;
  }

  // Métodos para acceder si quieres usar sin `.value`
  String get getUsername => username.value;
  String get getToken => token.value;
  int get getUserId => userId.value;
}