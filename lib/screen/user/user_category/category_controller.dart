import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:networking_practice/main.dart';
import 'package:networking_practice/screen/user/user_category/category_generic.dart';
import 'package:sembast/sembast.dart';

import '../../../core/network/api.dart';
import '../../../core/response/api_response.dart';
import '../../../database/local/database_helper.dart';
import '../../model/category/category_model.dart';
import '../../model/pair/pair.dart';

final categoryProvider = StateNotifierProvider<CategoryController, CategoryGeneric> ((ref) => CategoryController());

class CategoryController extends StateNotifier<CategoryGeneric> {
  CategoryController() : super(CategoryGeneric());

  static final _store = intMapStoreFactory.store('my_category'); // Local database

  // Local database
  getOfflineData() async {
    final db = await DatabaseHelper.getDatabase();
    final finder = Finder();  // You can customize the Finder if needed (for filtering, sorting, etc.)
    final data =  await _store.find(db, finder: finder);

    // Convert each record into a Pair<int, CarModel>
    List<Pair<int, CategoryModel>> category = data.map((e) {
      // Converting the Map<String, dynamic> (e.value) into CarModel using fromJson
      CategoryModel tmp = CategoryModel.fromJson(e.value);
      return Pair<int, CategoryModel>(e.key, tmp);  // Creating a Pair with key and CarModel
    }).toList();

    state = state.update(newCategory: category);
  }


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
        final db = await DatabaseHelper.getDatabase();
        // Clear all data from the store
        await _store.delete(db); // Local database

        for (var e in (apiResponse.data as List)){
          CategoryModel category = CategoryModel.fromJson(e as Map<String, dynamic>);
          myList.add(category);

          await _store.add(db, category.toJson());  // Add a new record
        }
        state = state.update(currentCategory: myList);
        await getOfflineData();
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