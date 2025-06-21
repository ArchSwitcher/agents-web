import 'package:agents_app/models/common/simple_entity_model.dart';

class DayModel {
  final String initTime;
  final String endTime;
  final int daysId;
  final SimpleEntity? day;

  DayModel({
    required this.initTime,
    required this.endTime,
    required this.daysId,
    this.day
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      initTime: json['Init_time'],
      endTime: json['End_time'],
      daysId: json['DAY']['Id'],
      day: json['DAY'] != null ? SimpleEntity.fromJson(json['DAY']) : null,
      
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "initTime": initTime,
      "endTime": endTime,
      "daysId": daysId,
    };
  }
}
