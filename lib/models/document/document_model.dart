  import 'package:agents_app/models/common/image_model.dart';
import 'package:agents_app/models/common/simple_entity_model.dart';

class DocumentModel extends ImageToUpload {
  final String? id;
  final String name;
  final SimpleEntity? documentType;
  // final String url;
  final String? description;

  DocumentModel({
    required this.id,
    required this.name,
    this.documentType,
    // this.url = '',
    this.description,
    required bool needUpdate,
    required String base64,
    required String link,
  });

  factory DocumentModel.fromJson(Map<String, dynamic> json) {
    return DocumentModel(
      id: json['Id']?.toString(),
      name: json['Name'],
      documentType: json['DOCUMENT_TYPE'] != null
          ? SimpleEntity.fromJson(json['DOCUMENT_TYPE'])
          : null,
      // url: json['url'] ?? '',
      link: json['url'] ?? '',
      description: json['description'],
      needUpdate: true,
      base64: ""
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "description": description,
      "url": link,
    };
  }
}
