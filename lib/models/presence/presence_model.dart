import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:agents_app/models/employee/employee_model.dart';

class PresenceModel {
  final int? id;
  final int? dayId;
  final String? startLatitude;
  final String? startLongitude;
  final DateTime? startDatetime;
  final String? endLatitude;
  final String? endLongitude;
  final int? positionEmployeId;
  final String? motive;
  final DateTime? endDatetime;
  final DateTime? createdAt;
  final EmployeeModel? employee;
  final String? startTime;
  final String? endTime;
  final String? endDate;
  final String? startDate;
  final SimpleEntity? day;

  PresenceModel({
    this.id,
    this.dayId,
    this.startLatitude,
    this.startLongitude,
    this.startDatetime,
    this.endLatitude,
    this.endLongitude,
    this.positionEmployeId,
    this.motive,
    this.endDatetime,
    this.createdAt,
    this.employee,
    this.startTime,
    this.endTime,
    this.endDate,
    this.startDate,
    this.day,
  });

  factory PresenceModel.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? dateStr) {
      try {
        if (dateStr == null) return null;
        return DateTime.parse(dateStr).toLocal();
      } catch (_) {
        return null;
      }
    }

    final DateTime? startDt = parseDate(json['Start_datetime']);
    final DateTime? endDt = parseDate(json['End_datetime']);

    return PresenceModel(
      id: json['Id'] as int?,
      dayId: json['DAY_Id'] as int?,
      day: json['DAY'] != null
          ? SimpleEntity.fromJson({
              "Id": json['DAY']?['Id'],
              "Name": json['DAY']?['Name'],
            })
          : null,
      startLatitude: json['Start_latitude'] as String?,
      startLongitude: json['Start_longitude'] as String?,
      startDatetime: startDt,
      endLatitude: json['End_latitude'] as String?,
      endLongitude: json['End_longitude'] as String?,
      positionEmployeId: json['POSITION_EMPLOYE_Id'] as int?,
      motive: json['Motive'] as String?,
      endDatetime: endDt,
      createdAt: parseDate(json['Created_at']),
      startTime: startDt != null
          ? startDt.toIso8601String().split('T')[1].replaceAll('.000', '')
          : null,
      endTime: endDt != null
          ? endDt.toIso8601String().split('T')[1].replaceAll('.000', '')
          : null,
      startDate: startDt != null
          ? startDt.toIso8601String().split('T')[0]
          : null,
      endDate: endDt != null
          ? endDt.toIso8601String().split('T')[0]
          : null,
      employee: json['POSITION_EMPLOYE'] != null &&
              json['POSITION_EMPLOYE']['EMPLOYE'] != null
          ? EmployeeModel.fromJson({
              ...?json['POSITION_EMPLOYE']?['EMPLOYE'],
              "position": {
                "POSITION_Id": json['POSITION_EMPLOYE']?['POSITION_Id'],
                "Is_principal": json['POSITION_EMPLOYE']?['Is_principal'],
                "Is_active": json['POSITION_EMPLOYE']?['Is_active'],
                "Motive": json['POSITION_EMPLOYE']?['Motive'],
              }
            })
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "Id": id,
      "DAY_Id": dayId,
      "Start_latitude": startLatitude,
      "Start_longitude": startLongitude,
      "Start_datetime": startDatetime?.toIso8601String(),
      "End_latitude": endLatitude,
      "End_longitude": endLongitude,
      "POSITION_EMPLOYE_Id": positionEmployeId,
      "Motive": motive,
      "End_datetime": endDatetime?.toIso8601String(),
      "Created_at": createdAt?.toIso8601String(),
      "POSITION_EMPLOYE": employee?.toJson(),
    };
  }
}

