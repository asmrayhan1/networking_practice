import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../utils/toast/toast_util.dart';
import '../task_controller.dart';

class OfflineTaskData extends ConsumerStatefulWidget {
  const OfflineTaskData({super.key});

  @override
  ConsumerState<OfflineTaskData> createState() => _OfflineTaskDataState();
}

class _OfflineTaskDataState extends ConsumerState<OfflineTaskData> {

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(taskProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: home.tmpTask.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Card(
                color: Colors.cyan,
                child: ListTile(
                  //tileColor: Colors.lightBlueAccent,
                  title: Text("${home.tmpTask[index].second.title}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                  subtitle: Text(maxLines: 1, "${home.tmpTask[index].second.description}", style: TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis)),
                  trailing: GestureDetector(
                      onTap: () {
                        ToastUtil.showToast(context: context, message: "No internet connection found!");
                      },
                      child: Icon(Icons.delete, color: Colors.white)
                  ),
                  onTap: () {
                    ToastUtil.showToast(context: context, message: "No internet connection found!");
                    print("Tapped on ${index}");
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}