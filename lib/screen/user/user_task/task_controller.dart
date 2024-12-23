import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart';
import 'package:networking_practice/screen/model/task/task_model.dart';
import 'package:networking_practice/screen/user/user_task/task_generic.dart';

import '../../../core/network/api.dart';
import '../../../core/response/api_response.dart';
import '../../../main.dart';

final taskProvider = StateNotifierProvider<TaskController, TaskGeneric> ((ref) => TaskController());

class TaskController extends StateNotifier<TaskGeneric> {
  TaskController() : super(TaskGeneric());

  Future<String?> addTask({required String title, required String description})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "title":title,
      "description":description
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await post(
        Uri.parse(Api.BASE_URL+Api.CREATETASK),
        headers: headers,
        body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300) {
      TaskModel task = TaskModel.fromJson(apiResponse.data as Map<String, dynamic>);
      await getMyTask();
      return null;
    }else{
      return apiResponse.data.toString();
    }
  }

  Future<void> getMyTask() async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer ${token}'
    };

    Response response = await get(
        Uri.parse(Api.BASE_URL+Api.GETMYTASk),
        headers: headers
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if (response.statusCode>=200 && response.statusCode<300) {
      List<TaskModel> myList = [];
      try {
        for (var e in (apiResponse.data as List)){
          TaskModel task = TaskModel.fromJson(e as Map<String, dynamic>);
          myList.add(task);
        }
        state = state.update(currentTask: myList);
      } catch (e){
        print("Error Found in Task");
      }
    }
  }

  Future<String?> updateTask({required String id, required String title, required String description})async{

    state = state.update(isLoading: true);

    Map<String, dynamic> payload = {
      "title": title,
      "description": description
    };

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await put(
        Uri.parse(Api.BASE_URL+Api.UPDATETASk+id),
        headers: headers,
        body: jsonEncode(payload)
    );

    state=state.update(isLoading: false);

    ApiResponse apiResponse = ApiResponse.fromJson(jsonDecode(response.body));
    if(response.statusCode>=200 && response.statusCode<300) {
      TaskModel categoryModel = TaskModel.fromJson(apiResponse.data as Map<String, dynamic>);
      await getMyTask();
      return null;
    }else{
      return apiResponse.data.toString();
    }
  }

  Future<int?> deleteMyTask({required String id}) async {
    state = state.update(isLoading: true);

    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization' : 'Bearer $token'
    };

    Response response = await delete(
        Uri.parse(Api.BASE_URL+Api.DELETETMYTASk+id),
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