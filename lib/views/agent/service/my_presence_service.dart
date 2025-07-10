import 'dart:convert';

import 'package:agents_app/models/presence/presence_model.dart';
import 'package:agents_app/services/base_service.dart';
import 'package:agents_app/services/crud_service.dart';
import 'package:agents_app/services/toast_service.dart';
import 'package:http/http.dart' as http;

class MyPresenceService extends BaseService
    implements CrudService<PresenceModel> {
  @override
  Future<List<PresenceModel>> getAll(dynamic value) {
    // TODO: implement getAll
    throw UnimplementedError();
  }

  @override
  Future<PresenceModel> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<bool> create(PresenceModel model) {
    // TODO: implement create
    throw UnimplementedError();
  }

  @override
  Future<bool> update(String id, PresenceModel model) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<bool> delete(String id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  // post initPresenceEmployee
  Future<bool> initPresenceEmployee(Map<String, dynamic> body) async {
    try {
      var bodyTempPresence;

      if (body["positionEmployeeId"] == null) {
        bodyTempPresence = {
          "idPresence": body["idPresence"],
          "startLatitud": body["startLatitud"],
          "startLongitude": body["startLongitude"],
          "motive": body["motive"]
        };
      } else {
        bodyTempPresence = {
          "dayId": body["dayId"],
          "startLatitud": body["startLatitud"],
          "startLongitude": body["startLongitude"],
          "positionEmployeeId": body["positionEmployeeId"],
          "motive": body["motive"]
        };
      }

      final response = await http.post(
        Uri.parse("$baseUrl/employee/initPresenceEmployee"),
        headers: buildHeaders(),
        body: jsonEncode(bodyTempPresence),
      );

      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        ToastService.success(
            title: "Asistencia", subTitle: "Asistencia iniciada");
        return true;
      } else {
        ToastService.error(
            title: "Error", subTitle: "No se pudo iniciar la asistencia");
        return false;
      }
    } catch (e) {
      print("Error initializing presence: $e");
      ToastService.error(
          title: "Error", subTitle: "No se pudo iniciar la asistencia");
      return false;
    }
  }

  Future<bool> markPresenceAsEnded(Map<String, dynamic> body) async {
    try {
      var bodyEndPresence = {
        "endLatitud": body["endLatitud"],
        "endLongitud": body["endLongitud"],
        "positionEmployeeId": body["positionEmployeeId"],
      };


      final response = await http.post(
        Uri.parse("$baseUrl/employee/endUpdatePresenceEmployee/${body["presenceId"]}"),
        headers: buildHeaders(),
        body: jsonEncode(bodyEndPresence),
      );

      print("Response status: ${response.statusCode}");

      if (response.statusCode == 200) {
        ToastService.success(
            title: "Asistencia", subTitle: "Asistencia finalizada");
        return true;
      } else {
        ToastService.error(
            title: "Error", subTitle: "No se pudo finalizar la asistencia");
        return false;
      }
    } catch (e) {
      print("Error ending presence: $e");
      ToastService.error(
          title: "Error", subTitle: "No se pudo finalizar la asistencia");
      return false;
    }
  }
}

// temporal
  // await employeeService.initUpdatePresence({
  //               id: params.idPresence,
  //               startLatitud: params.startLatitud,
  //               startLongitude: params.startLongitude,
  //               start_dataTime: new Date(),
  //               motive: params.motive,
  //           });
  //       } else {
  // permanent
  //           await employeeService.createPresenceEmployee({
  //               dayId: params.dayId,
  //               startLatitud: params.startLatitud,
  //               startLongitude: params.startLongitude,
  //               positionEmployeeId: params.positionEmployeeId,
  //               motive: params.motive,
  //               start_dataTime: new Date(),
  //           });