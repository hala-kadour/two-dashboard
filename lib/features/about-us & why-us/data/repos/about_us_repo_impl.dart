import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/data/datasources/about_us_remote_datasource.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/repos/about_us_repo.dart';

class AboutUsRepoImpl extends AboutUsRepo {
  final AboutUsRemoteDatasource aboutUsRemoteDatasource;

  AboutUsRepoImpl(this.aboutUsRemoteDatasource);
  @override
  Future<Either<Failure, AboutUsEntity>> createAboutUs(
    CreateAboutUsParam param,
  ) {
    return wrapHandling(
      tryCall: () async {
        final result = await aboutUsRemoteDatasource.createAboutUs(param);
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, AboutUsEntity>> showAboutUs() {
    return wrapHandling(
      tryCall: () async {
        final result = await aboutUsRemoteDatasource.showAboutUs();
        return Right(result.data);
      },
    );
  }

  @override
  Future<Either<Failure, Unit>> updateAboutUs(UpdateAboutUsParam param) {
    return wrapHandling(
      tryCall: () async {
        await aboutUsRemoteDatasource.updateAboutUs(param);
        return const Right(unit);
      },
    );
  }
}
