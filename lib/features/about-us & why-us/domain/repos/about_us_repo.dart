import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/error/handling_exception_manager.dart';
import 'package:two_dashboard/core/param/about_us_why_us_param.dart';
import 'package:two_dashboard/features/about-us%20&%20why-us/domain/entities/about_us_entity.dart';

abstract class AboutUsRepo with HandlingExceptionManager {
  Future<Either<Failure, AboutUsEntity>> showAboutUs();
  Future<Either<Failure, AboutUsEntity>> createAboutUs(
    CreateAboutUsParam param,
  );
  Future<Either<Failure, Unit>> updateAboutUs(UpdateAboutUsParam param);
}
