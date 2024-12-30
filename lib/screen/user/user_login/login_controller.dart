import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import '../../../core/network/api.dart';
import '../../../core/response/api_response.dart';
import '../../model/login/login_model.dart';
import 'login_generic.dart';

final loginProvider = StateNotifierProvider<LoginController, LoginGeneric>((ref)=>LoginController());

class LoginController extends StateNotifier<LoginGeneric>{
  LoginController():super(LoginGeneric());

  Future<String?> login({required String email, required String password})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "email":email,
      "password":password
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.LOGIN),
        headers: headers,
        body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300){
      LoginModel loginModel = LoginModel.fromJson(apiResponse.data as String);
      return loginModel.data.toString();
    }else{
      return null;
    }

  }

}