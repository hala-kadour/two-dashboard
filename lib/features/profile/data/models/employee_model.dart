import 'package:two_dashboard/features/profile/domain/entities/employee_entity.dart';

class EmployeeModel extends EmployeeEntity {
  EmployeeModel({
    required super.id,
    required super.name,
    required super.email,
    required super.image,
    required super.role,
    required super.cv,
    required super.approved,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => EmployeeModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"],
    role: json["role"],
    cv: json["cv"],
    approved: json["approved"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "role": role,
    "cv": cv,
    "approved": approved,
  };
}
