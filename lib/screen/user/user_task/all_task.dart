import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_task/create_task.dart';
import 'package:networking_practice/screen/user/user_task/task_controller.dart';
import 'package:networking_practice/screen/user/user_task/update_task.dart';

import '../../../utils/toast/toast_util.dart';

class AllTask extends ConsumerStatefulWidget {
  const AllTask({super.key});

  @override
  ConsumerState<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends ConsumerState<AllTask> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(taskProvider.notifier).getMyTask();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(taskProvider);
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            print("Working");
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTask()));
          },
          child: Card(
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("New Task", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        home.myTask.isEmpty? Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("No Task Found!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),)),
          ),
        ) : Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: home.myTask.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: ListTile(
                        //tileColor: Colors.lightBlueAccent,
                        title: Text("${home.myTask[index].title}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        subtitle: Text("${home.myTask[index].description}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
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
                            child: (home.myTask[index].isDeleted == true? CircularProgressIndicator() : Icon(Icons.delete))
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
        ),
      ],
    );
  }
}
