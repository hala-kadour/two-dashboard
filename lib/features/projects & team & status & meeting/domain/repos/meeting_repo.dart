import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/meeting_param.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/meeting/meeting_model.dart';

abstract class MeetingRepo with HandlingExceptionManager {
  Future<Either<Failure, Unit>> createMeeting(CreateMeetingParam param);
  Future<Either<Failure, List<MeetingModel>>> showProjectMeetingList(
    int projectId,
  );
  Future<Either<Failure, Unit>> updateMeeting(UpdateMeetingParam param);
  Future<Either<Failure, Unit>> deleteMeeting(DeleteMeetingParam param);
}
