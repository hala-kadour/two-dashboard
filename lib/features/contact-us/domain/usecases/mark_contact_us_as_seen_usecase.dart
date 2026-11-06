import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/contact-us/domain/repos/contact_us_repo.dart';

class MarkContactUsAsSeenUsecase
    extends UseCase<Future<Either<Failure, Unit>>, TokenWithIdParam> {
  MarkContactUsAsSeenUsecase(this.contactUsRepo);
  final ContactUsRepo contactUsRepo;

  @override
  Future<Either<Failure, Unit>> call(TokenWithIdParam param) {
    return contactUsRepo.markContactUsAsSeen(param);
  }
}
