import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/status_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/status_remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/show_project_board_response_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/status/status_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/status_repo.dart';

class StatusRepoImpl extends StatusRepo {
  final StatusRemoteDataSource statusRemoteDataSource;

  StatusRepoImpl(this.statusRemoteDataSource);
  @override
  Future<Either<Failure, Unit>> createStatus(CreateStatusParam param) {
    return wrapHandling(
      tryCall: () async {
        statusRemoteDataSource.createStatus(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteStatus(DeleteStatusParam param) {
    return wrapHandling(
      tryCall: () async {
        statusRemoteDataSource.deleteStatus(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<StatusModel>>> showStatus(
    TokenWithIdParam project,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await statusRemoteDataSource.showStatus(project);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateStatusOrder(
    UpdateStatusOrderParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        statusRemoteDataSource.updateStatusOrder(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<StatusBoardModel>>> showProjectBoard(
    ShowProjectBoardParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await statusRemoteDataSource.showProjectBoard(param);
        return Right(result.data);
      },
    );
  }
}
