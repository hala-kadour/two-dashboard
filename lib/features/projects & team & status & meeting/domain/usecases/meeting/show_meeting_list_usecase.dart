import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/data/models/meeting/meeting_model.dart';
import 'package:two_dashboard/features/projects%20&%20team%20&%20status%20&%20meeting/domain/repos/meeting_repo.dart';

class ShowMeetingListUsecase
    extends UseCase<Future<Either<Failure, List<MeetingModel>>>, int> {
  final MeetingRepo meetingRepo;

  ShowMeetingListUsecase(this.meetingRepo);

  @override
  Future<Either<Failure, List<MeetingModel>>> call(int param) {
    return meetingRepo.showProjectMeetingList(param);
  }
}
