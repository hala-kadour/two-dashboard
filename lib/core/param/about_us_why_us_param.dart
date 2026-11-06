import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';

// ** ABOUT-US ** //
class CreateAboutUsParam {
  final String token;
  final String workTime;
  final String site;

  CreateAboutUsParam({
    required this.token,
    required this.workTime,
    required this.site,
  });
}

class UpdateAboutUsParam {
  final String token;
  final AboutUsEntity aboutUs;

  UpdateAboutUsParam({required this.token, required this.aboutUs});
}

// ** WHY-US ** //
class CreateWhyUsParam {
  final String token;
  final String whyUs;

  CreateWhyUsParam({required this.token, required this.whyUs});
}

class UpdateWhyUsParam {
  final String token;
  final int whyUsId;
  final String whyUs;

  UpdateWhyUsParam({
    required this.token,
    required this.whyUsId,
    required this.whyUs,
  });
}
