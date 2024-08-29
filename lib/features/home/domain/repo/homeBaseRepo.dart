import 'package:dartz/dartz.dart';

import 'package:global_advice_new/core/error/failure.dart';
import 'package:global_advice_new/features/home/data/model/car_insurance_request_model.dart';
import 'package:global_advice_new/features/home/data/model/car_policy_request_model.dart';
import 'package:global_advice_new/features/home/data/model/health_dependinces_model.dart';
import 'package:global_advice_new/features/home/data/model/health_insurance_model.dart';
import 'package:global_advice_new/features/home/data/model/life_insurance_model.dart';
import 'package:global_advice_new/features/home/data/model/other_forms_model.dart';
import 'package:global_advice_new/features/home/data/model/property_model.dart';

import 'package:global_advice_new/features/home/data/model/car_dependinces_model.dart';
import 'package:global_advice_new/features/home/data/model/health_policy_request_model.dart';
import 'package:global_advice_new/features/home/data/model/property_dependinces_model.dart';
import 'package:global_advice_new/features/home/data/model/property_policy_request_model.dart';

abstract class BaseHomeRepository {
  Future<Either<Map<String, dynamic>, Failure>> SendHealthInsuranceRequest(
      HealthInsuranceModel healthInsuranceModel);

  Future<Either<Map<String, dynamic>, Failure>> SendCarInsuranceRequest(
      CarInusranceRequest carInusranceRequest);

  Future<Either<Map<String, dynamic>, Failure>> SendPropertyInsuranceRequest(
      PropertyModel propertyModel);

  Future<Either<Unit, Failure>> SendLifeInsuranceRequest(
      LifeInsuranceModel lifeInsuranceModel);

  Future<Either<Unit, Failure>> SendAnotherInsuranceRequest(
      OtherFormsModel otherFormsModel);
  Future<Either<Unit, Failure>> CarPolicyRequest(
      CarPolicyrequest otherFormsModel);
  Future<Either<Unit, Failure>> PropertyPolicyRequest(
      PropertyPolicyRequestModel otherFormsModel);
  Future<Either<Unit, Failure>> HealthPolicyRequest(
      HealthPolicyrequest otherFormsModel);

  Future<Either<List<CarData>, Failure>> Get_Car_Data();

  Future<Either<List<PropertyDependincesData>, Failure>> Get_Property_Data();
  Future<Either<List<HealthDependincesModel>, Failure>> Get_Health_Data();
}
