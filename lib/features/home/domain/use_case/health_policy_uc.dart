import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/health_policy_request_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class HealthPolicyUsecase extends BaseUseCase<Unit, HealthPolicyrequest> {
  BaseHomeRepository baseRepository;

  HealthPolicyUsecase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(
      HealthPolicyrequest healthPolicyModel) async {
    final result = await baseRepository.HealthPolicyRequest(healthPolicyModel);
    return result;
  }
}
