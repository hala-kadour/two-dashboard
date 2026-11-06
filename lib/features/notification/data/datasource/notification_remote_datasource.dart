import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/features/notification/data/models/show_notification_response_model.dart';
import 'package:two_dashboard/features/notification/data/models/show_unread_notification_list_reponse_model.dart';

abstract class NotificationRemoteDatasource {
  Future<ShowUnReadNotificationListResponseModel> showUnReadNotificationList(
    String token,
  );
  Future<ShowNotificationResponseModel> markNotifiAsRead(
    TokenWithStringIdParam param,
  );
}

class NotificationRemoteDatasourceImpl extends NotificationRemoteDatasource {
  @override
  Future<ShowNotificationResponseModel> markNotifiAsRead(
    TokenWithStringIdParam param,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/notification/${param.id}"),
      token: param.token,
      fromJson: showNotificationResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowUnReadNotificationListResponseModel> showUnReadNotificationList(
    String token,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/show/unread/notifications"),
      token: token,
      fromJson: showUnReadNotificationListResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
