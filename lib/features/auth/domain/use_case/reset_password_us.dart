import 'package:dartz/dartz.dart';
import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/auth/domain/repo/base_repo.dart';

class ResetPasswordUseCase extends BaseUseCase<Unit, String> {
  BaseRepository baseRepository;

  ResetPasswordUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(String email) async {
    final result = await baseRepository.resetPassword(email);
    return result;
  }
}
