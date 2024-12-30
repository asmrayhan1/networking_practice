import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/components/custom_container.dart';
import 'package:networking_practice/screen/user/user_task/create_task.dart';
import 'package:networking_practice/screen/user/user_task/task_controller.dart';

import '../../../../utils/toast/toast_util.dart';
import 'get_task_data.dart';
import 'offline_task_data.dart';

class AllTask extends ConsumerStatefulWidget {
  const AllTask({super.key});

  @override
  ConsumerState<AllTask> createState() => _AllTaskState();
}

class _AllTaskState extends ConsumerState<AllTask> {
  bool _internet = true;

  @override
  void initState() {
    // TODO: implement initState
    
    WidgetsBinding.instance.addPostFrameCallback((t){
      // Internet Connection
      // Listen for changes in connectivity status
      Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
        if (!mounted) return; // Check if widget is still mounted

        setState(() {
          if (result.contains(ConnectivityResult.wifi) || result.contains(ConnectivityResult.mobile)) {
            _internet = false;
          } else {
            _internet = true;
          }
        });
      });

      ref.read(taskProvider.notifier).getMyTask();
      ref.read(taskProvider.notifier).getOfflineData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(taskProvider);
    return Column(
      children: [
        SizedBox(height: 10),
        GestureDetector(
          onTap: (){
            print("Working");
            _internet? ToastUtil.showToast(context: context, message: "No internet connection found!") : Navigator.push(context, MaterialPageRoute(builder: (context) => CreateTask()));
          },
          child: Card(
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("New Task", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        _internet? home.tmpTask.isEmpty? CustomContainer(message: "No task Found") : OfflineTaskData()
            : home.myTask.isEmpty? CustomContainer(message: "No task Found!") : GetTaskData()
      ],
    );
  }
}
