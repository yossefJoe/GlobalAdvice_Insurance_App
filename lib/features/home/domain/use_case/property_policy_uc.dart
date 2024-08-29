import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/property_policy_request_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class PropertyPolicyUseCase extends BaseUseCase<Unit, PropertyPolicyRequestModel> {
  BaseHomeRepository baseRepository;

  PropertyPolicyUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(
      PropertyPolicyRequestModel propertyPolicyModel) async {
    final result =
        await baseRepository.PropertyPolicyRequest(propertyPolicyModel);
    return result;
  }
}
