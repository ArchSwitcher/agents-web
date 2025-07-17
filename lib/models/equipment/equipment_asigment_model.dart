class EquipmentAssignmentModel {
  final int id;
  final int employeeId;
  final int equipmentId;
  final DateTime assignedAt;
  final DateTime? returnedAt;
  final String? notes;
  final int status;
  final int quantity;
  final bool isReturned;
  final String? serialNumber;
  final int? returnQuantity;
  final String? returnNotes;
  final Equipment? equipment;

  EquipmentAssignmentModel({
    required this.id,
    required this.employeeId,
    required this.equipmentId,
    required this.assignedAt,
    this.returnedAt,
    this.notes,
    required this.status,
    required this.quantity,
    required this.isReturned,
    this.serialNumber,
    this.returnQuantity,
    this.returnNotes,
    this.equipment,
  });

  factory EquipmentAssignmentModel.fromJson(Map<String, dynamic> json) {
    return EquipmentAssignmentModel(
      id: json['Id'],
      employeeId: json['EMPLOYEE_Id'],
      equipmentId: json['EQUIPMENT_Id'],
      assignedAt: DateTime.parse(json['AssignedAt']),
      returnedAt: json['ReturnedAt'] != null ? DateTime.tryParse(json['ReturnedAt']) : null,
      notes: json['Notes'],
      status: json['Status'],
      quantity: json['Quantity'],
      isReturned: json['IsReturned'] ?? false,
      serialNumber: json['SerialNumber'],
      returnQuantity: json['Return_quantity'],
      returnNotes: json['Return_notes'],
      equipment: json['EQUIPMENT'] != null ? Equipment.fromJson(json['EQUIPMENT']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'EMPLOYEE_Id': employeeId,
      'EQUIPMENT_Id': equipmentId,
      'AssignedAt': assignedAt.toIso8601String(),
      'ReturnedAt': returnedAt?.toIso8601String(),
      'Notes': notes,
      'Status': status,
      'Quantity': quantity,
      'IsReturned': isReturned,
      'SerialNumber': serialNumber,
      'Return_quantity': returnQuantity,
      'Return_notes': returnNotes,
      'EQUIPMENT': equipment?.toJson(),
    };
  }
}

class Equipment {
  final int id;
  final int quantity;
  final int cost;
  final String currency;
  final int status;
  final String? serialNumber;
  final int isAssigned;
  final int equipmentTypeId;
  final EquipmentType? equipmentType;

  Equipment({
    required this.id,
    required this.quantity,
    required this.cost,
    required this.currency,
    required this.status,
    this.serialNumber,
    required this.isAssigned,
    required this.equipmentTypeId,
    this.equipmentType,
  });

  factory Equipment.fromJson(Map<String, dynamic> json) {
    return Equipment(
      id: json['Id'],
      quantity: json['Quantity'],
      cost: json['Cost'],
      currency: json['Currency'],
      status: json['Status'] ?? 0,
      serialNumber: json['SerialNumber'],
      isAssigned: json['IsAssigned'],
      equipmentTypeId: json['EQUIPMENT_TYPE_Id'],
      equipmentType: json['EQUIPMENT_TYPE'] != null
          ? EquipmentType.fromJson(json['EQUIPMENT_TYPE'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Quantity': quantity,
      'Cost': cost,
      'Currency': currency,
      'Status': status,
      'SerialNumber': serialNumber,
      'IsAssigned': isAssigned,
      'EQUIPMENT_TYPE_Id': equipmentTypeId,
      'EQUIPMENT_TYPE': equipmentType?.toJson(),
    };
  }
}

class EquipmentType {
  final int id;
  final String name;
  final int status;
  final int isUnique;
  final int? equipmentKitId;

  EquipmentType({
    required this.id,
    required this.name,
    required this.status,
    required this.isUnique,
    this.equipmentKitId,
  });

  factory EquipmentType.fromJson(Map<String, dynamic> json) {
    return EquipmentType(
      id: json['Id'],
      name: json['Name'],
      status: json['Status'],
      isUnique: json['IsUnique'],
      equipmentKitId: json['EQUIPMENT_KIT_Id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Name': name,
      'Status': status,
      'IsUnique': isUnique,
      'EQUIPMENT_KIT_Id': equipmentKitId,
    };
  }
}
