import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/auth/data/models/user_model.dart';
import 'package:two_dashboard/features/auth/domain/repos/auth_repo.dart';

class RegisterLoginWithGithupUsecase
    extends NoParamUseCase<Future<Either<Failure, UserModel>>> {
  final AuthRepo authRepo;

  RegisterLoginWithGithupUsecase(this.authRepo);

  @override
  Future<Either<Failure, UserModel>> call() {
    return authRepo.registLoginWithGithup();
  }
}
