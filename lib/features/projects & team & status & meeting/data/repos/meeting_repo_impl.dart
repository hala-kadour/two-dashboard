import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/meeting_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/datasource/meeting_remote_data_source.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/meeting/meeting_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/meeting_repo.dart';

class MeetingRepoImpl extends MeetingRepo {
  final MeetingRemoteDataSource meetingRemoteDataSource;

  MeetingRepoImpl(this.meetingRemoteDataSource);
  @override
  Future<Either<Failure, Unit>> createMeeting(CreateMeetingParam param) {
    return wrapHandling(
      tryCall: () async {
        await meetingRemoteDataSource.createMeeting(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteMeeting(DeleteMeetingParam param) {
    return wrapHandling(
      tryCall: () async {
        await meetingRemoteDataSource.deleteMeeting(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<MeetingModel>>> showProjectMeetingList(
    int projectId,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await meetingRemoteDataSource.showProjectMeetingList(
          projectId,
        );
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateMeeting(UpdateMeetingParam param) {
    return wrapHandling(
      tryCall: () async {
        await meetingRemoteDataSource.updateMeeting(param);
        return Right(unit);
      },
    );
  }
}
