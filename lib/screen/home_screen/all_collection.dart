import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/toast/toast_util.dart';
import '../user/user_task/task_controller.dart';

class AllCollection extends ConsumerStatefulWidget {
  const AllCollection({super.key});

  @override
  ConsumerState<AllCollection> createState() => _AllCollectionState();
}

class _AllCollectionState extends ConsumerState<AllCollection> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(taskProvider.notifier).getOfflineData();
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
        home.tmpTask.isEmpty? Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("No Task Found!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),)),
          ),
        ) : Expanded(
          child: ListView.builder(
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
                              //ToastUtil.showToast(context: context, message: "No internet connection found!");
                            },
                            child: Icon(Icons.delete, color: Colors.white)
                        ),
                        onTap: () {
                          //ToastUtil.showToast(context: context, message: "No internet connection found!");
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
