import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/home/data/model/other_forms_model.dart';

class OtherInsuranceUseCase extends BaseUseCase<Unit, OtherFormsModel> {
  BaseHomeRepository baseRepository;

  OtherInsuranceUseCase({required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(OtherFormsModel otherFormsModel) async {
    final result =
        await baseRepository.SendAnotherInsuranceRequest(otherFormsModel);
    return result;
  }
}
