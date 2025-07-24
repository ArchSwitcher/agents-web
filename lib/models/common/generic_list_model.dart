class GenericListModel {
  final int id;
  final String name;

  GenericListModel({
    required this.id,
    required this.name,
  });

  factory GenericListModel.fromJson(Map<String, dynamic> json) {
    return GenericListModel(
      id: json['id'] ?? json['Id'],
      name: json['name'] ?? json['Name'],
    );
  }
}
