import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/no_param_use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/team_repo.dart';

class ShowTeamsUsecase
    extends NoParamUseCase<Future<Either<Failure, List<TeamEntity>>>> {
  final TeamRepo teamRepo;

  ShowTeamsUsecase(this.teamRepo);
  @override
  Future<Either<Failure, List<TeamEntity>>> call() {
    return teamRepo.showTeams();
  }
}
