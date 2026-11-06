import 'dart:developer';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/profile_param.dart';
import 'package:two_dashboard/features/profile/data/models/get_user_profile_response_model.dart';
import 'package:two_dashboard/features/profile/data/models/show_clients_response_model.dart';
import 'package:two_dashboard/features/profile/data/models/show_users_with_filter_response_model.dart';

abstract class ProfileRemoteDatasourse {
  Future<EmptyResponseModel> updateEmployeeProfile(
    UpdateEmployeeProfileParam param,
  );
  Future<GetUserProfileResponseModel> getUserProfile(String token);
  Future<ShowUsersWithFilterResponseModel> showUserWithFilter(
    ShowUsersParam param,
  );
  Future<ShowClientsResponseModel> showClients();
  Future<EmptyResponseModel> toggleUserApproved(TokenWithIdParam user);
  Future<Uint8List> getImage(String imagePath);
}

class ProfileRemoteDatasourseImpl extends ProfileRemoteDatasourse {
  @override
  Future<EmptyResponseModel> updateEmployeeProfile(
    UpdateEmployeeProfileParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/employee/profile"),
      body: ({
        'image': '$imageBase64${param.image}',
        'cv': '$pdfBase64${param.cv}',
        'role_id': param.roleId.toString(),
        'phone': param.phoneNumber,
      }),
      fromJson: emptyResponseModelFromJson,
      token: param.token,
    );
    return await result.call();
  }

  @override
  Future<ShowUsersWithFilterResponseModel> showUserWithFilter(
    ShowUsersParam param,
  ) async {
    String uri =
        "$baseUri/api/show/users?filter[approved]=${param.approvedFilter}&filter[role_id]=${param.roleFilter}";
    final result = GetWithTokenApi(
      uri: Uri.parse(uri),
      token: param.token,
      fromJson: showUsersWithFilterResponseModelFromJson,
    );

    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> toggleUserApproved(TokenWithIdParam user) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/toggle/user/approved/${user.id}"),
      token: user.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowClientsResponseModel> showClients() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/clients"),
      fromJson: showClientsResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<GetUserProfileResponseModel> getUserProfile(String token) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/user/profile"),
      token: token,
      fromJson: getUserProfileResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<Uint8List> getImage(String imagePath) async {
    // final result = PostApi(
    //   uri: Uri.parse("$baseUri/api/get/image"),
    //   body: ({'filename': imagePath}),
    //   fromJson: (body) {},
    // );
    final response = await http.post(
      Uri.parse('$baseUri/api/get/image?filename=$imagePath'),
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      log("${response.statusCode}");
      log(response.body);
      return response.bodyBytes;
    }
  }
}
