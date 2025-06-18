class EmployeeModel {
  final int id;
  final int status;
  final EmployeeType employeeType;
  final Person person;

  EmployeeModel({
    required this.id,
    required this.status,
    required this.employeeType,
    required this.person,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) {
    return EmployeeModel(
      id: json['id'],
      status: json['status'],
      employeeType: EmployeeType.fromJson(json['employeeType']),
      person: Person.fromJson(json['person']),
    );
  }
}

class Person {
  final int id;
  final String firstName;
  final String lastName;
  final String contact;
  final String sex;

  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.contact,
    required this.sex,
  });

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      contact: json['contact'],
      sex: json['sex'],
    );
  }
}

class EmployeeType {
  final int id;
  final String name;

  EmployeeType({
    required this.id,
    required this.name,
  });

  factory EmployeeType.fromJson(Map<String, dynamic> json) {
    return EmployeeType(
      id: json['id'],
      name: json['name'],
    );
  }
}
