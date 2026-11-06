import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/contact_us_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contact-us/data/models/contact_us_model.dart';
import 'package:two_dashboard/features/contact-us/domain/repos/contact_us_repo.dart';

class ShowContactUsWithSeenAndApprovedUsecase
    extends
        UseCase<
          Future<Either<Failure, List<ContactUsModel>>>,
          ShowContactUsParam
        > {
  ShowContactUsWithSeenAndApprovedUsecase(this.contactUsRepo);
  final ContactUsRepo contactUsRepo;

  @override
  Future<Either<Failure, List<ContactUsModel>>> call(ShowContactUsParam param) {
    return contactUsRepo.showContactUsWithSeenAndApproved(param);
  }
}
