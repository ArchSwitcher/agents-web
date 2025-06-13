class GroupsModel {
  final int id;
  final String name;
  final int status;

  GroupsModel({
    required this.id,
    required this.name,
    required this.status,
  });

  factory GroupsModel.fromJson(Map<String, dynamic> json) {
    return GroupsModel(
      id: json['Id'],
      name: json['Name'],
      status: json['Status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Status': status,
    };
  }
}
