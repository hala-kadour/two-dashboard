import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/contact_us_param.dart';
import 'package:two_dashboard/features/contact-us/data/models/contact_us_model.dart';

abstract class ContactUsRepo with HandlingExceptionManager {
  Future<Either<Failure, List<ContactUsModel>>>
  showContactUsWithSeenAndApproved(ShowContactUsParam param);
  Future<Either<Failure, ContactUsModel>> createContactUs(
    CreateContactUsParam param,
  );
  Future<Either<Failure, Unit>> markContactUsAsSeen(TokenWithIdParam contactUs);
  Future<Either<Failure, Unit>> markContactUsAsApproved(
    TokenWithIdParam contactUs,
  );
}
