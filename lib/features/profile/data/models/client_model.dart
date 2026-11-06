import 'package:two_dashboard/features/profile/domain/entities/client_entity.dart';

class ClientModel extends ClientEntity {
  final int id;
  final String name;
  final String email;
  final String image;
  final String role;

  ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.image,
    required this.role,
  }) : super(cId: id, cName: name, cEmail: email, cImage: image, cRole: role);

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    image: json["image"] ?? '',
    role: json["role"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "image": image,
    "role": role,
  };
}
