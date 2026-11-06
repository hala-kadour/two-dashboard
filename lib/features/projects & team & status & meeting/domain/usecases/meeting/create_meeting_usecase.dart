import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/meeting_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/meeting_repo.dart';

class CreateMeetingUsecase
    extends UseCase<Future<Either<Failure, Unit>>, CreateMeetingParam> {
  final MeetingRepo meetingRepo;

  CreateMeetingUsecase(this.meetingRepo);

  @override
  Future<Either<Failure, Unit>> call(CreateMeetingParam param) {
    return meetingRepo.createMeeting(param);
  }
}
