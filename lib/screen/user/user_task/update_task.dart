import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_task/task_controller.dart';

import '../../../utils/toast/toast_util.dart';

class UpdateTask extends ConsumerWidget {
  final String id;
  final String title;
  final String description;
  UpdateTask({super.key, required this.id, required this.title, required this.description});

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    _titleController.text = title;
    _descriptionController.text = description;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: GestureDetector (
            onTap: (){
              print("ID => ${id}");
              print("Title => ${title}");
              print("Description => ${description}");
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)
        ),
        title: Text("Update Task", style: TextStyle(fontSize: 24, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () async {
                  if (_titleController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty){
                    ToastUtil.showToast(context: context, message: "Field can't be Empty!");
                    return;
                  }
                  print("ID no : ${id}");
                  print("Title : ${_titleController.text.trim()}");
                  print("Description : ${_descriptionController.text.trim()}");
                  final serverError = await ref.read(taskProvider.notifier).updateTask(id: id, title: _titleController.text.trim(), description: _descriptionController.text.trim());
                  if(serverError==null){
                    ToastUtil.showToast(context: context, message: "Task Updated Successfully", isWarning: false);
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
                controller: _titleController,
                maxLength: 40,
                maxLines: 1,
                decoration: InputDecoration(
                  counter: Offstage(),
                  border: InputBorder.none,
                  hintText: "Title Name",
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
                  hintText: "Title Description",
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
