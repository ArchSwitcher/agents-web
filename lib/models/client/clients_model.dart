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
      name: json['Name'],
      email: json['Email'],
      url: json['Url'],
      phone: json['Phone'].toString(),
      group: Group.fromJson(json['group']),
      admin: Admin.fromJson(json['admin']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'Name': name,
      'Email': email,
      'Url': url,
      'Phone': phone,
      'group': group.toJson(),
      'admin': admin.toJson(),
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
