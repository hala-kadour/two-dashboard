class CreatePostParam {
  final String token;
  final String image;
  final String description;
  CreatePostParam({
    required this.token,
    required this.image,
    required this.description,
  });
}

class ReplyToPostParam {
  final String fullName;
  final String email;
  final String phone;
  final String cv;
  final int postId;
  ReplyToPostParam({
    required this.fullName,
    required this.email,
    required this.phone,
    required this.cv,
    required this.postId,
  });
}
