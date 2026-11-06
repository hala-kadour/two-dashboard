// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:bloc/bloc.dart';

import 'package:two_dashboard/core/network/enums.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/post_param.dart';
import 'package:two_dashboard/core/services/shared_preferences_services.dart';
import 'package:two_dashboard/features/posts/domain/entities/post_entity.dart';
import 'package:two_dashboard/features/posts/domain/entities/reply_entity.dart';
import 'package:two_dashboard/features/posts/domain/usecases/accept_reply_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/create_post_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/delete_post_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/reply_to_post_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/show_active_posts_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/show_post_accepted_replies_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/show_post_replies_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/show_un_active_posts_usecase.dart';
import 'package:two_dashboard/features/posts/domain/usecases/un_active_post_usecase.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final AcceptReplyUsecase acceptReplyUsecase;
  final CreatePostUsecase createPostUsecase;
  final DeletePostUsecase deletePostUsecase;
  final ReplyToPostUsecase replyToPostUsecase;
  final ShowActivePostsUsecase showActivePostsUsecase;
  final ShowPostAcceptedRepliesUsecase showPostAcceptedRepliesUsecase;
  final ShowPostRepliesUsecase showPostRepliesUsecase;
  final ShowUnActivePostsUsecase showUnActivePostsUsecase;
  final UnActivePostUsecase unActivePostUsecase;
  PostBloc({
    required this.acceptReplyUsecase,
    required this.createPostUsecase,
    required this.deletePostUsecase,
    required this.replyToPostUsecase,
    required this.showActivePostsUsecase,
    required this.showPostAcceptedRepliesUsecase,
    required this.showPostRepliesUsecase,
    required this.showUnActivePostsUsecase,
    required this.unActivePostUsecase,
  }) : super(PostState()) {
    // CREATE POST //
    on<CreatePostEvent>((event, emit) async {
      emit(state.copyWith(createPostStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await createPostUsecase.call(
          CreatePostParam(
            token: token,
            image: event.image,
            description: event.body,
          ),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              createPostStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(createPostStatus: CasualStatus.success)),
        );
      } else {
        emit(state.copyWith(createPostStatus: CasualStatus.not_authorized));
      }
    });
    // DELETE POST //
    on<DeletePostEvent>((event, emit) async {
      emit(state.copyWith(deletePostStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await deletePostUsecase.call(
          TokenWithIdParam(id: event.postId, token: token),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              deletePostStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(deletePostStatus: CasualStatus.success)),
        );
      } else {
        emit(state.copyWith(deletePostStatus: CasualStatus.not_authorized));
      }
    });
    // UN ACTIVE POST //
    on<UnActivePostEvent>((event, emit) async {
      emit(state.copyWith(unActivePostStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await unActivePostUsecase.call(
          TokenWithIdParam(id: event.postId, token: token),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              unActivePostStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(unActivePostStatus: CasualStatus.success)),
        );
      } else {
        emit(state.copyWith(unActivePostStatus: CasualStatus.not_authorized));
      }
    });
    // GET ACTIVE POSTS //
    on<GetActivePostsEvent>((event, emit) async {
      emit(state.copyWith(activePostsListStatus: CasualStatus.loading));
      final result = await showActivePostsUsecase.call();
      result.fold(
        (l) => emit(
          state.copyWith(
            activePostsListStatus: CasualStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            activePostsListStatus: CasualStatus.success,
            activePostsList: r,
          ),
        ),
      );
    });
    // GET UN ACTIVE POST //
    on<GetUnActivePostsEvent>((event, emit) async {
      emit(state.copyWith(unActivePostsListStatus: CasualStatus.loading));
      final result = await showUnActivePostsUsecase.call();
      result.fold(
        (l) => emit(
          state.copyWith(
            unActivePostsListStatus: CasualStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(
          state.copyWith(
            unActivePostsListStatus: CasualStatus.success,
            unActivePostsList: r,
          ),
        ),
      );
    });
    // GET POST  REPLIES //
    on<GetPostsRepliesEvent>((event, emit) async {
      emit(state.copyWith(postsRepliesListStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await showPostRepliesUsecase.call(
          TokenWithIdParam(id: event.postId, token: token),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              postsRepliesListStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              postsRepliesListStatus: CasualStatus.success,
              postRepliesList: r,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(postsRepliesListStatus: CasualStatus.not_authorized),
        );
      }
    });
    // GET POST  ACCEPTED REPLIES //
    on<GetPostsAcceptedRepliesEvent>((event, emit) async {
      emit(state.copyWith(postsRepliesListStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await showPostAcceptedRepliesUsecase.call(
          TokenWithIdParam(id: event.postId, token: token),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              postsRepliesListStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(
            state.copyWith(
              postsRepliesListStatus: CasualStatus.success,
              postRepliesList: r,
            ),
          ),
        );
      } else {
        emit(
          state.copyWith(postsRepliesListStatus: CasualStatus.not_authorized),
        );
      }
    });
    // ACCEPT A REPLY //
    on<AcceptReplyEvent>((event, emit) async {
      emit(state.copyWith(acceptReplyStatus: CasualStatus.loading));
      final String? token = await SharedPreferencesServices.getUserToken();
      if (token != null) {
        final result = await acceptReplyUsecase.call(
          TokenWithIdParam(id: event.replyId, token: token),
        );
        result.fold(
          (l) => emit(
            state.copyWith(
              acceptReplyStatus: CasualStatus.failure,
              message: l.message,
            ),
          ),
          (r) => emit(state.copyWith(acceptReplyStatus: CasualStatus.success)),
        );
      } else {
        emit(state.copyWith(acceptReplyStatus: CasualStatus.not_authorized));
      }
    });
    // REPLY TO POST //
    on<ReplyToPostEvent>((event, emit) async {
      emit(state.copyWith(sendReplyStatus: CasualStatus.loading));
      final result = await replyToPostUsecase.call(
        ReplyToPostParam(
          fullName: event.fullName,
          email: event.email,
          phone: event.phone,
          cv: event.cv,
          postId: event.postId,
        ),
      );
      result.fold(
        (l) => emit(
          state.copyWith(
            sendReplyStatus: CasualStatus.failure,
            message: l.message,
          ),
        ),
        (r) => emit(state.copyWith(sendReplyStatus: CasualStatus.success)),
      );
    });
  }
}
