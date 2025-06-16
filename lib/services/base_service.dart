import 'package:agents_app/controllers/globals.dart';
import 'package:agents_app/services/config.dart';
import 'package:get/get.dart';

abstract class BaseService {
  String get baseUrl => Config.endPointBaseUrl; // o Config.endPointBaseUrl

  Map<String, String> buildHeaders() {
    final authController = Get.find<SessionController>();
    return {
      'Authorization': 'bearer ${authController.getToken}',
      'Content-Type': 'application/json',
    };
  }
}
