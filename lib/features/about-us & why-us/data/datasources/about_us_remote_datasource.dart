import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/models/about-us-models/create_why_us_response_model.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/models/about-us-models/show_about_us_response_model.dart';

abstract class AboutUsRemoteDatasource {
  Future<ShowAboutUsResponesModel> showAboutUs();
  Future<CreateAboutUsResponesModel> createAboutUs(CreateAboutUsParam aboutUs);
  Future<EmptyResponseModel> updateAboutUs(UpdateAboutUsParam aboutUs);
}

class AboutUsRemoteDatasourceImpl extends AboutUsRemoteDatasource {
  @override
  Future<CreateAboutUsResponesModel> createAboutUs(
    CreateAboutUsParam aboutUs,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/about"),
      token: aboutUs.token,
      body: ({'work_time': aboutUs.workTime, 'site': aboutUs.site}),
      fromJson: createAboutUsResponesModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<ShowAboutUsResponesModel> showAboutUs() async {
    final result = GetApi(
      uri: Uri.parse("$baseUri/api/show/about"),
      fromJson: showAboutUsResponesModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<EmptyResponseModel> updateAboutUs(UpdateAboutUsParam aboutUs) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/update/about"),
      token: aboutUs.token,
      body: ({
        'work_time': aboutUs.aboutUs.aboutWorkTime,
        'site': aboutUs.aboutUs.aboutSite,
        'about_id': aboutUs.aboutUs.aboutId,
      }),
      fromJson: emptyResponseModelFromJson,
    );
    return await result.call();
  }
}
