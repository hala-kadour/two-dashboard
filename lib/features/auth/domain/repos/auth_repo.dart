import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/auth_param.dart';
import 'package:two_dashboard/features/auth/data/models/user_model.dart';

abstract class AuthRepo with HandlingExceptionManager {
  Future<Either<Failure, UserModel>> registNewUser(SignUpParam param);
  Future<Either<Failure, UserModel>> registLoginWithGoogle();
  Future<Either<Failure, UserModel>> registLoginWithGithup();
  Future<Either<Failure, UserModel>> loginUser(LoginParam param);
  Future<Either<Failure, Unit>> logoutUser(String token);
}
