import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_project_board_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';

class ShowProjectBoardUsecase
    extends
        UseCase<
          Future<Either<Failure, List<StatusBoardModel>>>,
          ShowProjectBoardParam
        > {
  final StatusRepo statusRepo;

  ShowProjectBoardUsecase(this.statusRepo);

  @override
  Future<Either<Failure, List<StatusBoardModel>>> call(
    ShowProjectBoardParam param,
  ) {
    return statusRepo.showProjectBoard(param);
  }
}
