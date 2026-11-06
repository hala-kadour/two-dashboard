import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_project_board_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';

abstract class StatusRepo with HandlingExceptionManager {
  // craete status
  Future<Either<Failure, Unit>> createStatus(CreateStatusParam param);
  // delete status
  Future<Either<Failure, Unit>> deleteStatus(DeleteStatusParam param);
  // update order
  Future<Either<Failure, Unit>> updateStatusOrder(UpdateStatusOrderParam param);

  // get status
  Future<Either<Failure, List<StatusModel>>> showStatus(
    TokenWithIdParam project,
  );
  // get board
  Future<Either<Failure, List<StatusBoardModel>>> showProjectBoard(
    ShowProjectBoardParam param,
  );
}
