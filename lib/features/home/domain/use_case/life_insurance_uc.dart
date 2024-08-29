import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/home/data/model/life_insurance_model.dart';

class LifeInsuranceUseCase extends BaseUseCase<Unit, LifeInsuranceModel> {
  BaseHomeRepository baseRepository;

  LifeInsuranceUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(
      LifeInsuranceModel lifeInsuranceModel) async {
    final result =
        await baseRepository.SendLifeInsuranceRequest(lifeInsuranceModel);
    return result;
  }
}
