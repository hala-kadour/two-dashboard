import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/notification/domain/repo/notification_repo.dart';

class MarkNotificationAsReadUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithStringIdParam> {
  final NotificationRepo notificationRepo;

  MarkNotificationAsReadUsecase(this.notificationRepo);

  @override
  Future<Either<Failure, Unit>> call(TokenWithStringIdParam param) {
    return notificationRepo.markNotifiAsRead(param);
  }
}
