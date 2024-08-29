import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/car_policy_request_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class CarPolicyUseCase extends BaseUseCase<Unit, CarPolicyrequest> {
  BaseHomeRepository baseRepository;

  CarPolicyUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(CarPolicyrequest CarInsuranceModel) async {
    final result = await baseRepository.CarPolicyRequest(CarInsuranceModel);
    return result;
  }
}
