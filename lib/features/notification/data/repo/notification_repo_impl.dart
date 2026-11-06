import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/features/notification/data/datasource/notification_remote_datasource.dart';
import 'package:two_dashboard/features/notification/data/models/notification_model.dart';
import 'package:two_dashboard/features/notification/domain/repo/notification_repo.dart';

class NotificationRepoImpl extends NotificationRepo {
  final NotificationRemoteDatasource notificationDatasource;

  NotificationRepoImpl(this.notificationDatasource);
  @override
  Future<Either<Failure, Unit>> markNotifiAsRead(TokenWithStringIdParam param) {
    return wrapHandling(
      tryCall: () async {
        await notificationDatasource.markNotifiAsRead(param);
        return Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<NotificationModel>>> showUnReadNotificationList(
    String token,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await notificationDatasource.showUnReadNotificationList(
          token,
        );
        return Right(result.data);
      },
    );
  }
}
