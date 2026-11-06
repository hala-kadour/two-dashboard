import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/auth_param.dart';
import 'package:two_dashboard/features/auth/data/models/auth_response_model.dart';

import '../../../../core/api/post_api.dart';
import '../../../../core/api/post_api_with_token.dart';

abstract class AuthRemoteDataSource {
  Future<AuthResponseModel> regist(SignUpParam param);
  Future<AuthResponseModel> login(LoginParam param);
  Future<EmptyResponseModel> logout(String token);
  Future<AuthResponseModel> registLoginWithGoogle();
  Future<AuthResponseModel> registLoginWithGithup();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<AuthResponseModel> regist(SignUpParam param) async {
    final result = PostApi(
      uri: Uri.parse("$baseUri/api/register"),
      body: ({
        'name': param.name,
        'email': param.email,
        'password': param.password,
        'password_confirmation': param.confirmPassword,
      }),
      fromJson: authResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<AuthResponseModel> login(LoginParam param) async {
    final result = PostApi(
      uri: Uri.parse("$baseUri/api/login"),
      body: ({'email': param.email, 'password': param.password}),
      fromJson: authResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> logout(String token) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/logout"),
      token: token,
      body: ({}),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<AuthResponseModel> registLoginWithGithup() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/auth/github/callback"),
      fromJson: authResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<AuthResponseModel> registLoginWithGoogle() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/auth/google/callback"),
      fromJson: authResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
