import 'package:agents_app/models/common/simple_entity_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DailySchedule {
  final String initTime;
  final String endTime;
  final int daysId;
  final SimpleEntity? day;

  DailySchedule({
    required this.initTime,
    required this.endTime,
    required this.daysId,
    this.day
  });

  factory DailySchedule.fromJson(Map<String, dynamic> json) {
    return DailySchedule(
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


class WeekDay {
  final int id;
  final String name;
  final TextEditingController startTimeController;
  final TextEditingController endTimeController;
  final RxBool isSelected;

  WeekDay({
    required this.id,
    required this.name,
    required this.startTimeController,
    required this.endTimeController,
    required this.isSelected,
  });
}
