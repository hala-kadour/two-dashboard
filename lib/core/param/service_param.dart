class CreateServiceParam {
  final String token;
  final String title;
  final String description;
  final String image;
  CreateServiceParam({
    required this.token,
    required this.title,
    required this.description,
    required this.image,
  });
}

class UpdateServiceParam {
  final String token;
  final String serviceId;
  final String title;
  final String description;
  final String image;

  UpdateServiceParam({
    required this.token,
    required this.serviceId,
    required this.title,
    required this.description,
    required this.image,
  });
}
