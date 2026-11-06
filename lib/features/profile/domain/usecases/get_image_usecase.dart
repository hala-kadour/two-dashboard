import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:two_dashboard/core/error/failures.dart';
import 'package:two_dashboard/core/usecases/use_case.dart';
import 'package:two_dashboard/features/profile/domain/repos/profile_repo.dart';

class GetImageUsecase
    extends UseCase<Future<Either<Failure, Uint8List>>, String> {
  final ProfileRepo profileRepo;

  GetImageUsecase(this.profileRepo);
  @override
  Future<Either<Failure, Uint8List>> call(String param) {
    return profileRepo.getImage(param);
  }
}
