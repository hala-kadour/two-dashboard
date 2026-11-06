import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/core/param/contact_us_param.dart';
import 'package:two_dashboard/features/contact-us/data/datasources/contact_us_remote_datasource.dart';
import 'package:two_dashboard/features/contact-us/data/models/contact_us_model.dart';
import 'package:two_dashboard/features/contact-us/domain/repos/contact_us_repo.dart';

class ContactUsRepoImpl extends ContactUsRepo {
  ContactUsRepoImpl(this.contactUsRemoteDatasource);
  final ContactUsRemoteDatasource contactUsRemoteDatasource;

  @override
  Future<Either<Failure, ContactUsModel>> createContactUs(
    CreateContactUsParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await contactUsRemoteDatasource.createContactUs(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> markContactUsAsApproved(
    TokenWithIdParam contactUs,
  ) async {
    return wrapHandling(
      tryCall: () async {
        await contactUsRemoteDatasource.approveContactUs(contactUs);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> markContactUsAsSeen(
    TokenWithIdParam contactUs,
  ) async {
    return wrapHandling(
      tryCall: () async {
        await contactUsRemoteDatasource.seenContactUs(contactUs);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<ContactUsModel>>>
  showContactUsWithSeenAndApproved(ShowContactUsParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await contactUsRemoteDatasource
            .showContactUsWithSeenAndApproved(param);
        return Right(result.data);
      },
    );
  }
}
