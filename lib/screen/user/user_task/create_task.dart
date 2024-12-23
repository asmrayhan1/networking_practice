import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_task/task_controller.dart';

import '../../../utils/toast/toast_util.dart';

class CreateTask extends ConsumerWidget {
  CreateTask({super.key});

  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: GestureDetector (
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)
        ),
        title: Text("Create New Task", style: TextStyle(fontSize: 24, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () async {
                  if (_nameController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty){
                    ToastUtil.showToast(context: context, message: "Field can't be Empty!");
                    return;
                  }
                  final serverError = await ref.read(taskProvider.notifier).addTask(title: _nameController.text.trim(), description: _descriptionController.text.trim());
                  if(serverError==null){
                    ToastUtil.showToast(context: context, message: "Task created Successfully", isWarning: false);
                    Navigator.of(context).pop();
                  }else{
                    ToastUtil.showToast(context: context, message: serverError, isWarning: true);
                  }
                },
                child: Icon(Icons.save, color: Colors.white,)
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _nameController,
                maxLength: 40,
                maxLines: 1,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                  hintText: "Task Name",
                  hintStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
                ),
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600
                ),
              ),
              TextField(
                controller: _descriptionController,
                maxLines: 30,
                maxLength: 1000,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                  hintText: "Task Description",
                  hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                style: TextStyle (
                    fontSize: 20
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
