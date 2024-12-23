import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';
import 'package:networking_practice/utils/toast/toast_util.dart';

class CreateCategory extends ConsumerStatefulWidget {
  const CreateCategory({super.key});

  @override
  ConsumerState<CreateCategory> createState() => _CategoryState();
}

class _CategoryState extends ConsumerState<CreateCategory> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        leading: GestureDetector (
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Icon(Icons.arrow_back,color: Colors.white,)
        ),
        title: Text("Create New category", style: TextStyle(fontSize: 24, color: Colors.white),),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
                onTap: () async {
                  if (_nameController.text.trim().isEmpty || _descriptionController.text.trim().isEmpty){
                    ToastUtil.showToast(context: context, message: "Field can't be Empty!");
                    return;
                  }
                  final serverError = await ref.read(categoryProvider.notifier).addCategory(name: _nameController.text.trim(), description: _descriptionController.text.trim());
                  if(serverError==null){
                    ToastUtil.showToast(context: context, message: "Category created Successfully", isWarning: false);
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
                  hintText: "Category Name",
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
                  hintText: "Category Description",
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
