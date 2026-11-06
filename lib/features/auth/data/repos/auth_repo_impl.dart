import 'package:dartz/dartz.dart';

import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/auth_param.dart';
import 'package:two_dashboard/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:two_dashboard/features/auth/data/models/user_model.dart';
import 'package:two_dashboard/features/auth/domain/repos/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepoImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, UserModel>> loginUser(LoginParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await authRemoteDataSource.login(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> logoutUser(String token) {
    return wrapHandling(
      tryCall: () async {
        await authRemoteDataSource.logout(token);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> registNewUser(SignUpParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await authRemoteDataSource.regist(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> registLoginWithGithup() {
    return wrapHandling(
      tryCall: () async {
        final result = await authRemoteDataSource.registLoginWithGithup();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, UserModel>> registLoginWithGoogle() {
    return wrapHandling(
      tryCall: () async {
        final result = await authRemoteDataSource.registLoginWithGoogle();
        return Right(result.data);
      },
    );
  }
}
