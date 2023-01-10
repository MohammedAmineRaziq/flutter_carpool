import 'dart:convert' as convert;
import 'dart:convert';
import 'package:carpool_app/Services/shared_service.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import '../models/LoginRequestModel.dart';
import '../models/LoginResponseModel.dart';

class AuthService {
  static var client = http.Client();

  static Future<bool> login(LoginRequestModel model, ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.https(
      Config.AuthURL,
      Config.loginAPI,
    );
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if (response.statusCode == 200) {
      await SharedService.setLoginDetails(
        loginResponseJson(
          response.body,
        ),
      );
      return true;
    } else {
      return false;
    }
  }


  static Future<String> getRole() async {
    var loginDetails = await SharedService.loginDetails();
    return loginDetails!.role!;
  }

  /*static Future<bool> register( RegisterRequestModel model,) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.http(
      Config.apiURL,
      Config.registerAPI,
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(model.toJson()),
    );
    if(response.statusCode == 201){
      return true;
    }else{
      return false;
    }
  }

  static Future<UserModel> getUserProfile() async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${loginDetails!.data.token}',
    };
    var url = Uri.http(Config.apiURL, Config.userProfileAPI);

    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      return UserModel.fromJson(jsonResponse);
    }else{
      throw Exception('Failed to load user profile');
    }
  }

  static Future<bool> changePassword(String oldPassword , String newPassword) async {
    var loginDetails = await SharedService.loginDetails();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    'Authorization': 'Bearer ${loginDetails!.data.token}',
    };
    var url = Uri.http(
      Config.apiURL,
      Config.changePasswordAPI,
    );
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'oldPassword': oldPassword,
        'newPassword': newPassword,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> forgotPassword(String email) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(
      Config.apiURL,
      Config.forgotPassword2,
    );
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'email': email,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  static Future<bool> resetForgottenPassword(String email,String verificationCode ,String password) async {

    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };
    var url = Uri.http(
      Config.apiURL,
      Config.resetCustomerPassword,
    );
    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        'email': email,
        'verificationCode': verificationCode,
        'password': password,
      }),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
*/
}