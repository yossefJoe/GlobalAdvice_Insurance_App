import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/property_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class PropertyInsuranceUseCase
    extends BaseUseCase<Map<String, dynamic>, PropertyModel> {
  BaseHomeRepository baseRepository;

  PropertyInsuranceUseCase({required this.baseRepository});

  @override
  Future<Either<Map<String, dynamic>, Failure>> call(
      PropertyModel propertyModel) async {
    final result =
        await baseRepository.SendPropertyInsuranceRequest(propertyModel);
    return result;
  }
}
