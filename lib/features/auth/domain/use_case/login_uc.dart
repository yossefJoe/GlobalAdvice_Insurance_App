import 'package:dartz/dartz.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';
import 'package:global_advice_new/features/auth/domain/repo/base_repo.dart';

class LoginUseCase extends BaseUseCase<Map<String, dynamic>, LoginModel> {
  BaseRepository baseRepository;

  LoginUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      LoginModel parameter) async {
    final result = await baseRepository.loginWithEmailAndPassword(parameter);

    return result;
  }
}

class AuthModel {
  final String email;
  final String password;

  AuthModel({required this.email, required this.password});
}
