import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/meeting_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/meeting_repo.dart';

class DeleteMeetingUsecase
    extends UseCase<Future<Either<Failure, Unit>>, DeleteMeetingParam> {
  final MeetingRepo meetingRepo;

  DeleteMeetingUsecase(this.meetingRepo);

  @override
  Future<Either<Failure, Unit>> call(DeleteMeetingParam param) {
    return meetingRepo.deleteMeeting(param);
  }
}
