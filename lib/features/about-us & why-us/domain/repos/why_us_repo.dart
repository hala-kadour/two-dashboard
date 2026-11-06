import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/core/param/casule_param.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/why_us_entity.dart';

abstract class WhyUsRepo with HandlingExceptionManager {
  Future<Either<Failure, List<WhyUsEntity>>> showWhyUs();
  Future<Either<Failure, WhyUsEntity>> createWhyUs(CreateWhyUsParam param);
  Future<Either<Failure, Unit>> updateWhyUs(UpdateWhyUsParam param);
  Future<Either<Failure, Unit>> deleteWhyUs(TokenWithIdParam whyUs);
}
