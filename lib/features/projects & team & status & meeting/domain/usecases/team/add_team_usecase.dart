// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';

import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/team_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/team_repo.dart';

class AddTeamUsecase
    extends UseCase<Future<Either<Failure, Unit>>, AddTeamParam> {
  final TeamRepo teamRepo;

  AddTeamUsecase(this.teamRepo);

  @override
  Future<Either<Failure, Unit>> call(AddTeamParam param) {
    return teamRepo.addTeam(param);
  }
}
