import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/datasources/why_us_remote_datesource.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/why_us_repo.dart';

class WhyUsRepoImpl extends WhyUsRepo {
  final WhyUsRemoteDatesource whyUsRemoteDatesource;

  WhyUsRepoImpl(this.whyUsRemoteDatesource);
  @override
  Future<Either<Failure, WhyUsEntity>> createWhyUs(CreateWhyUsParam param) {
    return wrapHandling(
      tryCall: () async {
        final result = await whyUsRemoteDatesource.createWhyUs(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> deleteWhyUs(TokenWithIdParam whyUs) {
    return wrapHandling(
      tryCall: () async {
        await whyUsRemoteDatesource.deleteWhyUs(whyUs);
        return const Right(unit);
      },
    );
  }

  @override
  Future<Either<Failure, List<WhyUsEntity>>> showWhyUs() {
    return wrapHandling(
      tryCall: () async {
        final result = await whyUsRemoteDatesource.showWhyUs();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateWhyUs(UpdateWhyUsParam param) {
    return wrapHandling(
      tryCall: () async {
        await whyUsRemoteDatesource.updateWhyUs(param);
        return const Right(unit);
      },
    );
  }
}
