class EmployeeEntity {
  final int id;
  final String name;
  final String email;
  final String? image;
  final String role;
  final String? cv;
  final int approved;

  EmployeeEntity({
    required this.id,
    required this.name,
    required this.email,
    this.image,
    required this.role,
    this.cv,
    required this.approved,
  });
}
