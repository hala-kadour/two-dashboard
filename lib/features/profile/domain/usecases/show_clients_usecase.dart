import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/profile/domain/entities/client_entity.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class ShowClientsUsecase
    extends NoParamUseCase<Future<Either<Failure, List<ClientEntity>>>> {
  ShowClientsUsecase(this.profileRepo);
  final ProfileRepo profileRepo;

  @override
  Future<Either<Failure, List<ClientEntity>>> call() {
    return profileRepo.showClients();
  }
}
