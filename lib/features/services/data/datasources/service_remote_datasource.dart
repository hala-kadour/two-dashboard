import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/service_param.dart';
import 'package:two_dashboard/features/services/data/models/create_service_response_model.dart';
import 'package:two_dashboard/features/services/data/models/show_service_response_model.dart';

abstract class ServiceRemoteDatasource {
  Future<CreateServiceResponesModel> createService(CreateServiceParam param);
  Future<EmptyResponseModel> deleteService(TokenWithIdParam service);
  Future<ShowServiceResponesModel> showServices();
  Future<EmptyResponseModel> updateService(UpdateServiceParam param);
}

class ServiceRemoteDatasourceImpl extends ServiceRemoteDatasource {
  @override
  Future<CreateServiceResponesModel> createService(
    CreateServiceParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/service"),
      token: param.token,
      body: ({
        'title': param.title,
        'description': param.description,
        'image': '$imageBase64${param.image}',
      }),
      fromJson: createServiceResponesModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> deleteService(TokenWithIdParam service) async {
    final result = GetWithTokenApi(
      uri: Uri.parse('$baseUri/api/delete/service/${service.id}'),
      token: service.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowServiceResponesModel> showServices() async {
    final result = GetApi(
      uri: Uri.parse('$baseUri/api/show/services'),
      fromJson: showServiceResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> updateService(UpdateServiceParam param) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/service"),
      token: param.token,
      body: ({
        'title': param.title,
        'description': param.description,
        'image': '$imageBase64${param.image}',
        'service_id': param.serviceId.toString(),
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }
}
