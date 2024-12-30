import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';

import '../../../../utils/toast/toast_util.dart';
import '../update_category.dart';

class GetCategoryData extends ConsumerStatefulWidget {
  const GetCategoryData({super.key});

  @override
  ConsumerState<GetCategoryData> createState() => _GetCategoryDataState();
}

class _GetCategoryDataState extends ConsumerState<GetCategoryData> {
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: home.myCategory.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Card(
                  color: Colors.cyan,
                  child: ListTile(
                    //tileColor: Colors.lightBlueAccent,
                    title: Text("${home.myCategory[index].name}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                    subtitle: Text(maxLines: 1, "${home.myCategory[index].description}", style: TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis)),
                    trailing: GestureDetector(
                        onTap: () async {
                          home.myCategory[index].isDeleted = true;
                          int? status = await ref.read(categoryProvider.notifier).deleteMyCategory(id: home.myCategory[index].id!);
                          if (status! >= 200 && status < 300) {
                            await ref.read(categoryProvider.notifier).getMyCategory();
                            ToastUtil.showToast(context: context, message: "Successfully Category Deleted");
                          } else {
                            home.myCategory[index].isDeleted = true;
                            ToastUtil.showToast(context: context, message: "Error Found");
                          }
                          print("Delete Icon is Working");
                          print(status);
                        },
                        child: (home.myCategory[index].isDeleted == true? CircularProgressIndicator() : Icon(Icons.delete, color: Colors.white,))
                    ),
                    onTap: () {
                      final current = home.myCategory[index];
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateCategory(
                        id: current.id!, name: current.name!, description: current.description!,)),
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
