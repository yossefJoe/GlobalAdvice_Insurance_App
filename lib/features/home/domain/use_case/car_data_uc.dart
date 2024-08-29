import 'package:dartz/dartz.dart';
import 'package:global_advice_new/features/home/data/model/car_dependinces_model.dart';
import 'package:global_advice_new/features/home/domain/repo/homeBaseRepo.dart';

import 'package:global_advice_new/core/base_use_case/base_use_case.dart';
import 'package:global_advice_new/core/error/failure.dart';

class CarDataUseCase extends BaseUseCase<List<CarData>, Noparamiter> {
  BaseHomeRepository baseRepository;

  CarDataUseCase({required this.baseRepository});

  @override
  Future<Either<List<CarData>, Failure>> call(Noparamiter parameter) async {
    final result = await baseRepository.Get_Car_Data();
    return result;
  }
}
