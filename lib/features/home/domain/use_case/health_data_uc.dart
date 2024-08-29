import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/health_dependinces_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class FetchingHealthDataUseCase
    extends BaseUseCase<List<HealthDependincesModel>, Noparamiter> {
  BaseHomeRepository baseRepository;

  FetchingHealthDataUseCase({required this.baseRepository});

  @override
  Future<Either<List<HealthDependincesModel>, Failure>> call(
      Noparamiter parameter) async {
    final result = await baseRepository.Get_Health_Data();
    return result;
  }
}
