import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:networking_practice/main.dart';
import 'package:networking_practice/screen/user/user_category/category_generic.dart';

import '../../../core/network/api.dart';
import '../../../core/response/api_response.dart';
import '../../model/category/category_model.dart';

final categoryProvider = StateNotifierProvider<CategoryController, CategoryGeneric> ((ref) => CategoryController());

class CategoryController extends StateNotifier<CategoryGeneric> {
  CategoryController() : super(CategoryGeneric());

  Future<String?> addCategory({required String name, required String description})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "name":name,
      "description":description
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.CREATECATEGORY),
        headers: headers,
        body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300) {
      CategoryModel registerModel = CategoryModel.fromJson(apiResponse.data as Map<String, dynamic>);
      await getMyCategory();
      return null;
    }else{
      return apiResponse.data.toString();
    }
  }

  Future<void> getMyCategory() async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'
    };

    Response response = await get(
        Uri.parse(Api.BASE_URL+Api.GETMYCATEGORY),
        headers: headers
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode>=200 && response.statusCode<300) {
      List<CategoryModel> myList = [];
      try {
        for (var e in (apiResponse.data as List)){
          CategoryModel category = CategoryModel.fromJson(e as Map<String, dynamic>);
          myList.add(category);
        }
        state = state.update(currentCategory: myList);
      } catch (e){
        print("Error Found in Category");
      }
    }
  }

  Future<String?> updateCategory({required String id, required String name, required String description})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "name": name,
      "description": description
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await put(
        Uri.parse(Api.BASE_URL+Api.UPDATECATEGORY+id),
        headers: headers,
        body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300) {
      CategoryModel categoryModel = CategoryModel.fromJson(apiResponse.data as Map<String, dynamic>);
      await getMyCategory();
      return null;
    }else{
      return apiResponse.data.toString();
    }
  }

  Future<int?> deleteMyCategory({required String id}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await delete(
        Uri.parse(Api.BASE_URL+Api.DELETEMYCATEGORY+id),
        headers: headers
    );

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode>=200 && response.statusCode<300) {
      print(response.statusCode);
      return 200;
    } else {
      print(response.statusCode);
      return 0;
    }
  }
}