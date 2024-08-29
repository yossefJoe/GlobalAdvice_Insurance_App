import 'package:dartz/dartz.dart';

import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';

abstract class BaseRepository {
  Future<Either<Map<String, dynamic>, Failure>> loginWithEmailAndPassword(
      LoginModel authModel);
  Future<Either<Unit, Failure>> registerWithEmailAndPassword(
      LoginModel registerAuthModel);
  Future<Either<Unit, Failure>> resetPassword(String email);
}
