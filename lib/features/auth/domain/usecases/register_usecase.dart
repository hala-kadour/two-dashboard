import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/param/auth_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/auth/data/models/user_model.dart';
import 'package:two_dashboard/features/auth/domain/repos/auth_repo.dart';

import '../../../../core/error/failures.dart';

class RegisterUsecase
    extends UseCase<Future<Either<Failure, UserModel>>, SignUpParam> {
  final AuthRepo authRepo;
  RegisterUsecase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call(SignUpParam param) async {
    return await authRepo.registNewUser(param);
  }
}
