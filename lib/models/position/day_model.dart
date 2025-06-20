class DayModel {
  final String initTime;
  final String endTime;
  final int daysId;

  DayModel({
    required this.initTime,
    required this.endTime,
    required this.daysId,
  });

  factory DayModel.fromJson(Map<String, dynamic> json) {
    return DayModel(
      initTime: json['Init_time'],
      endTime: json['End_time'],
      daysId: json['DAY']['Id'],
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
