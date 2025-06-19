class ClientModel {
  final String? id;
  final String name;
  final String email;
  final String url;
  final String phone;
  final Group group;
  final Admin admin;

  ClientModel({
    this.id,
    required this.name,
    required this.email,
    required this.url,
    required this.phone,
    required this.group,
    required this.admin,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['id'].toString(),
      name: json['Name'].toString(),
      email: json['Email'] ?? '',
      url: json['Url'] ?? '',
      phone: json['Phone'] != null ? json['Phone'].toString() : '',
      group: Group.fromJson(json['group']),
      admin: Admin.fromJson(json['admin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'url': url,
      'phone': phone,
      'groupId': group.id,
      'adminId': admin.id,
    };
  }
}

class Group {
  final String id;
  final String name;

  Group({required this.id, required this.name});

  factory Group.fromJson(Map<String, dynamic> json) {
    return Group(
      id: json['id'].toString(),
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
    };
  }
}

class Admin {
  final String id;
  final String name;

  Admin({required this.id, required this.name});

  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'].toString(),
      name: json['Name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
    };
  }
}
