import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/notification/data/models/notification_model.dart';
import 'package:two_dashboard/features/notification/domain/repo/notification_repo.dart';

class ShowUnReadNotificationUsecase
    extends UseCase<Future<Either<Failure, List<NotificationModel>>>, String> {
  final NotificationRepo notificationRepo;

  ShowUnReadNotificationUsecase(this.notificationRepo);

  @override
  Future<Either<Failure, List<NotificationModel>>> call(String param) {
    return notificationRepo.showUnReadNotificationList(param);
  }
}
