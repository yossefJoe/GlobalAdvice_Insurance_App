import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/health_insurance_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class HealthInsuranceUseCase
    extends BaseUseCase<Map<String, dynamic>, HealthInsuranceModel> {
  BaseHomeRepository baseRepository;

  HealthInsuranceUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      HealthInsuranceModel healthInsuranceModel) async {
    final result =
        await baseRepository.SendHealthInsuranceRequest(healthInsuranceModel);
    return result;
  }
}
