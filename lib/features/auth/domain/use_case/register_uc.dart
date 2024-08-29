import 'package:dartz/dartz.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';
import 'package:global_advice_new/features/auth/domain/repo/base_repo.dart';

class RegisterUseCase extends BaseUseCase<Unit, LoginModel> {
  BaseRepository baseRepository;

  RegisterUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(LoginModel parameter) async {
    final result = await baseRepository.registerWithEmailAndPassword(parameter);

    return result;
  }
}

class RegisterAuthModel {
  final String email;
  final String password;
  final String name;
  final int telephone;

  RegisterAuthModel({
    required this.email,
    required this.password,
    required this.name,
    required this.telephone,
  });
}
