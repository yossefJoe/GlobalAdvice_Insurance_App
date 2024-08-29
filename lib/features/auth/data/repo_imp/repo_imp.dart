import 'package:dartz/dartz.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/features/auth/domain/repo/base_repo.dart';
import 'package:global_advice_new/features/auth/data/data_source/remotly_data_source.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';

class RepositoryImp extends BaseRepository {
  final BaseRemotelyDataSource baseRemotelyDataSource;

  RepositoryImp({required this.baseRemotelyDataSource});

  @override
  Future<Either<Map<String, dynamic>, Failure>> loginWithEmailAndPassword(
      LoginModel authModel) async {
    try {
      final result =
          await baseRemotelyDataSource.loginWithEmailAndPassword(authModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Unit, Failure>> registerWithEmailAndPassword(
      LoginModel registerAuthModel) async {
    try {
      final result = await baseRemotelyDataSource
          .registerWithEmailAndPassword(registerAuthModel);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Unit, Failure>> resetPassword(String email) async {
    try {
      final result = await baseRemotelyDataSource.resetPasswordWithEmail(email);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
}
