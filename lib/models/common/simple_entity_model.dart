class SimpleEntity {
  final String id;
  final String name;

  SimpleEntity({required this.id, required this.name});

  factory SimpleEntity.fromJson(Map<String, dynamic> json) {
    return SimpleEntity(
      id: json['id'] != null ? json['id'].toString() : '',
      name: json['name'] != null ? json['name'].toString() : '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
