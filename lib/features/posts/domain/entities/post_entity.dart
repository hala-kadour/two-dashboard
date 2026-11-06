class PostEntity {
  final int postId;
  final String poster;
  final String body;
  final int? active;
  PostEntity({
    required this.postId,
    required this.poster,
    required this.body,
    required this.active,
  });
}
