import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:networking_practice/core/network/api.dart';
import 'package:networking_practice/core/response/api_response.dart';
import 'package:networking_practice/screen/model/register/register_model.dart';
import 'package:networking_practice/screen/user/user_register/register_generic.dart';

final registerProvider = StateNotifierProvider<RegisterController, RegisterGeneric>((ref)=>RegisterController());

class RegisterController extends StateNotifier<RegisterGeneric>{
  RegisterController():super(RegisterGeneric());

  Future<String?> signup({
    required String email,
    required String password,
    required String confirmPassword
})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "email":email,
      "password":password,
      "confirmPassword":confirmPassword
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Response response = await post(
      Uri.parse(Api.BASE_URL+Api.REGISTER),
      headers: headers,
      body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300){
      RegisterModel registerModel = RegisterModel.fromJson(apiResponse.data as Map<String, dynamic>);
      return null;
    }else{
      return apiResponse.data.toString();
    }





  }

}