  import 'package:agents_app/models/common/simple_entity_model.dart';

class Document {
  final String id;
  final String name;
  final String documentTypeId;
  final SimpleEntity? documentType;

  Document({
    required this.id,
    required this.name,
    required this.documentTypeId,
    this.documentType,
  });

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      id: json['Id'].toString(),
      name: json['Name'],
      documentTypeId: json['DOCUMENT_TYPE_Id'].toString(),
      documentType: json['DOCUMENT_TYPE'] != null
          ? SimpleEntity.fromJson(json['DOCUMENT_TYPE'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "documentTypeId": documentTypeId,
    };
  }
}
