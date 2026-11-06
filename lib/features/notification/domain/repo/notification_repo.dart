import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/features/notification/data/models/notification_model.dart';

abstract class NotificationRepo with HandlingExceptionManager {
  Future<Either<Failure, List<NotificationModel>>> showUnReadNotificationList(
    String token,
  );
  Future<Either<Failure, Unit>> markNotifiAsRead(TokenWithStringIdParam param);
}
