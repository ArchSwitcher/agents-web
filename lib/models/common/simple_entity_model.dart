class SimpleEntity {
  final String id;
  final String name;

  SimpleEntity({required this.id, required this.name});

  factory SimpleEntity.fromJson(Map<String, dynamic> json) {
    // sometimes id is Id or id, and name can be Name or name
    // this handles both cases by checking for both keys
    // and converting them to strings if they are not null
    // if the key is not present, it defaults to an empty string
    // this is useful for ensuring that the model can handle different API responses
    // without throwing errors due to missing keys or null values
    if (json.isEmpty) {
      return SimpleEntity(id: '', name: '');
    }
    if (!json.containsKey('id') && !json.containsKey('Id')) {
      return SimpleEntity(id: '', name: '');
    }
    if (!json.containsKey('name') && !json.containsKey('Name')) {
      return SimpleEntity(id: json['id']?.toString() ?? '', name: '');
    }

    String id = json['id']?.toString() ?? json['Id']?.toString() ?? '';
    String name = json['name']?.toString() ?? json['Name']?.toString() ?? '';

    return SimpleEntity(
      id: id,
      name: name,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
