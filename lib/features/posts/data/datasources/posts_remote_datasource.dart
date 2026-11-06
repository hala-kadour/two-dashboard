import 'package:dartz/dartz.dart';
import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/api/put_request.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/post_param.dart';
import 'package:two_dashboard/features/posts/data/models/create_post_response_model.dart';
import 'package:two_dashboard/features/posts/data/models/reply_to_post_response_model.dart';
import 'package:two_dashboard/features/posts/data/models/show_post_replies_response_model.dart';
import 'package:two_dashboard/features/posts/data/models/show_post_response_model.dart';

abstract class PostRemoteDatasource {
  Future<CreatePostResponseModel> createPost(CreatePostParam param);
  Future<EmptyResponseModel> deletePost(TokenWithIdParam post);
  Future<ShowPostResponesModel> showActivePosts();
  Future<ShowPostResponesModel> showUnActivePosts();
  Future<Unit> unActivePost(TokenWithIdParam post);
  Future<ReplyToPostResponesModel> replyToPost(ReplyToPostParam param);
  Future<EmptyResponseModel> acceptReply(TokenWithIdParam reply);
  Future<ShowPostRepliesResponesModel> showPostReplies(TokenWithIdParam post);
  Future<ShowPostRepliesResponesModel> showPostAcceptedReplies(
    TokenWithIdParam post,
  );
}

class PostsRemoteDatasourceImpl implements PostRemoteDatasource {
  @override
  Future<CreatePostResponseModel> createPost(CreatePostParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/post"),
      body: ({
        'description': param.description,
        'image': '$imageBase64${param.image}',
      }),
      fromJson: createPostResponseModelFromJson,
      token: param.token,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deletePost(TokenWithIdParam post) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/delete/post/${post.id}"),
      token: post.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowPostResponesModel> showActivePosts() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/active/posts"),
      fromJson: showPostResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowPostResponesModel> showUnActivePosts() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/not/active/posts"),
      fromJson: showPostResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<Unit> unActivePost(TokenWithIdParam post) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/un/activate/post/${post.id}"),
      token: post.token,
      fromJson: showPostRepliesResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ReplyToPostResponesModel> replyToPost(ReplyToPostParam param) async {
    final result = PostApi(
      uri: Uri.parse("$baseUri/api/create/reply"),
      body: ({
        'full_name': param.fullName,
        'email': param.email,
        'phone': param.phone,
        'cv': '$pdfBase64${param.cv}',
        'post_id': param.postId,
      }),
      fromJson: replyToPostResponesModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> acceptReply(TokenWithIdParam reply) async {
    final result = PutApi(
      uri: Uri.parse("$baseUri/api/accept/reply/${reply.id}"),
      body: ({}),
      token: reply.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowPostRepliesResponesModel> showPostAcceptedReplies(
    TokenWithIdParam post,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/accepted/post/replies/${post.id}"),
      token: post.token,
      fromJson: showPostRepliesResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowPostRepliesResponesModel> showPostReplies(
    TokenWithIdParam post,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/post/replies/${post.id}"),
      token: post.token,
      fromJson: showPostRepliesResponesModelFromJson,
    );
    return await result.callRequest();
  }
}
