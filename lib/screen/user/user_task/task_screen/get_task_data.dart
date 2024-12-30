import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast/toast_util.dart';
import '../task_controller.dart';
import '../update_task.dart';

class GetTaskData extends ConsumerStatefulWidget {
  @override
  ConsumerState<GetTaskData> createState() => _GetTaskDataState();
}

class _GetTaskDataState extends ConsumerState<GetTaskData> {

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(taskProvider);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: home.myTask.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  color: Colors.cyan,
                  child: ListTile(
                    //tileColor: Colors.lightBlueAccent,
                    title: Text("${home.myTask[index].title}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                    subtitle: Text(maxLines: 1, "${home.myTask[index].description}", style: TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis)),
                    trailing: GestureDetector(
                        onTap: () async {
                          home.myTask[index].isDeleted = true;
                          int? status = await ref.read(taskProvider.notifier).deleteMyTask(id: home.myTask[index].id!);
                          if (status! >= 200 && status < 300) {
                            await ref.read(taskProvider.notifier).getMyTask();
                            ToastUtil.showToast(context: context, message: "Successfully Task Deleted");
                          } else {
                            home.myTask[index].isDeleted = false;
                            ToastUtil.showToast(context: context, message: "Error Found");
                          }
                          print("Delete Icon is Working");
                          print(status);
                        },
                        child: (home.myTask[index].isDeleted == true? CircularProgressIndicator() : Icon(Icons.delete, color: Colors.white))
                    ),
                    onTap: () {
                      final current = home.myTask[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateTask(
                          id: current.id!, title: current.title!, description: current.description!)),
                      );
                      print("Tapped on ${index}");
                    },
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
