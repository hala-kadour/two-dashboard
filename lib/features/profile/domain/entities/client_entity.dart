// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClientEntity {
  final int cId;
  final String cName;
  final String cEmail;
  final String? cImage;
  final String cRole;

  ClientEntity({
    required this.cId,
    required this.cName,
    required this.cEmail,
    this.cImage,
    required this.cRole,
  });
}
