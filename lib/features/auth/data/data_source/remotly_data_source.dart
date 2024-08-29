import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:global_advice_new/core/utils/api_helper.dart';
import 'package:global_advice_new/core/utils/constant_api.dart';
import 'package:global_advice_new/core/utils/methods.dart';
import 'package:global_advice_new/features/auth/data/model/login_model.dart';

abstract class BaseRemotelyDataSource {
  Future<Map<String, dynamic>> loginWithEmailAndPassword(LoginModel authModel);

  Future<Unit> registerWithEmailAndPassword(LoginModel registerAuthModel);

  Future<Unit> resetPasswordWithEmail(String email);
}

class AuthRemotelyDateSource extends BaseRemotelyDataSource {
  @override
  Future<Map<String, dynamic>> loginWithEmailAndPassword(
      LoginModel authModel) async {
    final body = {
      "email": authModel.email,
      "password": authModel.password,
    };

    try {
      final response = await Dio().post(
        options: Options(
          headers: {
            'Content-Type': Headers.formUrlEncodedContentType,
          },
        ),
        ConstantApi.login,
        data: FormData.fromMap(body),
      );
      Map<String, dynamic> jsonData = response.data;

      if (jsonData['status'] == 200) {
        return jsonData; // Return response data
      } else {
        throw Exception('Login failed with status code ${jsonData['error']}');
      }
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "loginWithEmailAndPassword");
    }
  }

  @override
  Future<Unit> registerWithEmailAndPassword(
      LoginModel registerAuthModel) async {
    final body = {
      "email": registerAuthModel.email,
      "password": registerAuthModel.password,
      "phone": registerAuthModel.telephone,
      "name": registerAuthModel.name,
    };
    print(body['email']);
    print(body['password']);
    print(body['phone']);
    print(body['name']);

    try {
      final response = await Dio().post(
        ConstantApi.register,
        data: FormData.fromMap(body),
        options: Options(
          headers: {
            'Content-Type': Headers.formUrlEncodedContentType,
          },
        ),
      );
      Map<String, dynamic> jsonData = response.data;

      if (jsonData['status'] != 200) {
        print(jsonData);
        throw new Exception(jsonData['error']);
      }

      LoginModel authModelResponse = LoginModel.fromJson(jsonData);

      Methods.instance.saveUserToken(authToken: authModelResponse.token);
      return Future.value(unit);
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "RegisterWithEmailAndPassword");
    }
  }

  @override
  Future<Unit> resetPasswordWithEmail(String email) async {
    final body = {
      "email": email,
    };
    try {
      final response = await Dio().post(
        options: Options(
          headers: {
            'Content-Type': 'application/x-www-form-urlencoded',
          },
        ),
        ConstantApi.resetPassword,
        data: body,
      );
      Map<String, dynamic> jsonData = response.data;

      if (jsonData['status'] == 200) {
        print(jsonData);
        print('Reset Password Successfully');
        return Future.value(unit);
      } else {
        throw Exception('Reset Password Failed');
      }
    } on DioException catch (e) {
      throw DioHelper.handleDioError(
          dioError: e, endpointName: "Reset Password");
    }
  }
}
