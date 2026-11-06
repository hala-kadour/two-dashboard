import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contact_us_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contact-us/data/models/contact_us_model.dart';
import 'package:two_dashboard/features/contact-us/domain/repos/contact_us_repo.dart';

class CreateContactUsUsecase
    extends
        UseCase<Future<Either<Failure, ContactUsModel>>, CreateContactUsParam> {
  CreateContactUsUsecase(this.contactUsRepo);
  final ContactUsRepo contactUsRepo;

  @override
  Future<Either<Failure, ContactUsModel>> call(CreateContactUsParam param) {
    return contactUsRepo.createContactUs(param);
  }
}
