import 'package:networking_practice/screen/model/pair/pair.dart';
import 'package:networking_practice/screen/model/task/task_model.dart';

class TaskGeneric {
  bool isLoading;
  List<TaskModel> myTask;
  List<Pair<int, TaskModel>> tmpTask;
  TaskGeneric({this.isLoading=false, this.myTask = const [], this.tmpTask = const []});
  TaskGeneric update({bool? isLoading, List<TaskModel>? currentTask, List<Pair<int, TaskModel>>? newTask}) {
    return TaskGeneric(
        isLoading: isLoading?? this.isLoading,
        myTask: currentTask?? this.myTask,
        tmpTask: newTask?? this.tmpTask
    );
  }
}