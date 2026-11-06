import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/auth_param.dart';

import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/auth/data/models/user_model.dart';
import 'package:two_dashboard/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/error/failures.dart';

class LoginUsecase
    extends UseCase<Future<Either<Failure, UserModel>>, LoginParam> {
  final AuthRepo authRepo;
  LoginUsecase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call(LoginParam param) async {
    return await authRepo.loginUser(param);
  }
}
