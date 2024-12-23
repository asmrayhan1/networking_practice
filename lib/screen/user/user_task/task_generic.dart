import 'package:networking_practice/screen/model/task/task_model.dart';

class TaskGeneric {
  bool isLoading;
  List<TaskModel> myTask;
  TaskGeneric({this.isLoading=false, this.myTask = const []});
  TaskGeneric update({bool? isLoading, List<TaskModel>? currentTask}) {
    return TaskGeneric(
        isLoading: isLoading?? this.isLoading,
        myTask: currentTask?? this.myTask
    );
  }
}