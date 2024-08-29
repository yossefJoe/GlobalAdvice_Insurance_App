import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/car_insurance_request_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class CarInsuranceUseCase
    extends BaseUseCase<Map<String, dynamic>, CarInusranceRequest> {
  BaseHomeRepository baseRepository;

  CarInsuranceUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      CarInusranceRequest CarInsuranceModel) async {
    final result =
        await baseRepository.SendCarInsuranceRequest(CarInsuranceModel);
    return result;
  }
}
