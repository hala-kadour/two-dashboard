import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/entity/team_entity.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/team_repo.dart';

class AddMembersUsecase
    extends UseCase<Future<Either<Failure, TeamEntity>>, AddTeamMembersParam> {
  final TeamRepo teamRepo;

  AddMembersUsecase(this.teamRepo);

  @override
  Future<Either<Failure, TeamEntity>> call(AddTeamMembersParam param) {
    return teamRepo.addMembers(param);
  }
}
