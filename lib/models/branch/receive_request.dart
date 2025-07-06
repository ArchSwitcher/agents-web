import 'package:agents_app/models/document/document_model.dart';

class BranchReceiveRequestModel {
  final List<DocumentModel> agentsPhotos;
  final DocumentModel letterPhoto;
  final DocumentModel equipmentPhoto;
  final DocumentModel groupAgentsPhoto;
  final DocumentModel receiverPhoto;
  final String startTime;
  final String endTime;
  final String agency;
  final bool requiresEvacuation;
  final String? translationLand;
  final int branchId;
  final String responsible;
  final String receiver;

  BranchReceiveRequestModel({
    required this.agentsPhotos,
    required this.letterPhoto,
    required this.equipmentPhoto,
    required this.groupAgentsPhoto,
    required this.receiverPhoto,
    required this.startTime,
    required this.endTime,
    required this.agency,
    required this.requiresEvacuation,
    this.translationLand,
    required this.branchId,
    required this.responsible,
    required this.receiver,
  });

  factory BranchReceiveRequestModel.fromJson(Map<String, dynamic> json) {
    return BranchReceiveRequestModel(
      agentsPhotos: (json['agentsPhotos'] as List)
          .map((e) => DocumentModel.fromJson(e))
          .toList(),
      letterPhoto: DocumentModel.fromJson(json['letterPhoto']),
      equipmentPhoto: DocumentModel.fromJson(json['equipmentPhoto']),
      groupAgentsPhoto: DocumentModel.fromJson(json['groupAgentsPhoto']),
      receiverPhoto: DocumentModel.fromJson(json['receiverPhoto']),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      agency: json['agency'] ?? '',
      requiresEvacuation: json['requiresEvacuation'] ?? false,
      translationLand: json['translationLand'],
      branchId: json['branchId'] ?? 0,
      responsible: json['responsible'] ?? '',
      receiver: json['receiver'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'agentsPhotos': agentsPhotos.map((e) => e.toJson()).toList(),
      'letterPhoto': letterPhoto.toJson(),
      'equipmentPhoto': equipmentPhoto.toJson(),
      'groupAgentsPhoto': groupAgentsPhoto.toJson(),
      'receiverPhoto': receiverPhoto.toJson(),
      'startTime': startTime,
      'endTime': endTime,
      'agency': agency,
      'requiresEvacuation': requiresEvacuation,
      'translationLand': translationLand,
      'branchId': branchId,
      'responsible': responsible,
      'receiver': receiver,
    };
  }
}
