import 'package:two_dashboard/config/constants/base_uri.dart';
import 'package:two_dashboard/core/api/get_api.dart';
import 'package:two_dashboard/core/api/get_with_token_api.dart';
import 'package:two_dashboard/core/api/post_api_with_token.dart';
import 'package:two_dashboard/core/models/empty_response_model.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/contact_us_param.dart';
import 'package:two_dashboard/features/contact-us/data/models/create_contact_us_response_model.dart';
import 'package:two_dashboard/features/contact-us/data/models/show_not_approved_contact_us_response_model.dart';

abstract class ContactUsRemoteDatasource {
  Future<CreateContactUsResponseModel> createContactUs(
    CreateContactUsParam param,
  );
  Future<ShowNotApprovedContactUsResponseModel>
  showContactUsWithSeenAndApproved(ShowContactUsParam param);
  Future<EmptyResponseModel> approveContactUs(TokenWithIdParam contactUs);
  Future<EmptyResponseModel> seenContactUs(TokenWithIdParam contactUs);
}

class ContactUsRemoteDatasourceImpl extends ContactUsRemoteDatasource {
  @override
  Future<EmptyResponseModel> approveContactUs(
    TokenWithIdParam contactUs,
  ) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/mark/contact/approved/${contactUs.id}"),
      token: contactUs.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<CreateContactUsResponseModel> createContactUs(
    CreateContactUsParam param,
  ) async {
    final result = PostWithTokenApi(
      uri: Uri.parse("$baseUri/api/create/contactUs"),
      token: param.token,
      body: ({
        'subject': param.subject,
        'description': param.description,
        'phone': param.phone,
      }),
      fromJson: createContactUsResponseModelFromJson,
    );
    return await result.call();
  }

  @override
  Future<EmptyResponseModel> seenContactUs(TokenWithIdParam contactUs) async {
    final result = GetWithTokenApi(
      uri: Uri.parse("$baseUri/api/mark/contact/seen/${contactUs.token}"),
      token: contactUs.token,
      fromJson: emptyResponseModelFromJson,
    );
    return await result.callRequest();
  }

  @override
  Future<ShowNotApprovedContactUsResponseModel>
  showContactUsWithSeenAndApproved(ShowContactUsParam param) async {
    final result = GetApi(
      uri: Uri.parse(
        "$baseUri/api/show/contactUs?filter[seen]=${param.seenFilter}&filter[tech_approved]=${param.approveFilter}",
      ),
      fromJson: showNotApprovedContactUsResponseModelFromJson,
    );
    return await result.callRequest();
  }
}
