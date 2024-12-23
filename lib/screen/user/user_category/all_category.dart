import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';
import 'package:networking_practice/screen/user/user_category/create_category.dart';
import 'package:networking_practice/screen/user/user_category/update_category.dart';
import 'package:networking_practice/utils/toast/toast_util.dart';

class AllCategory extends ConsumerStatefulWidget {
  const AllCategory({super.key});

  @override
  ConsumerState<AllCategory> createState() => _State();
}

class _State extends ConsumerState<AllCategory> {
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((t){
      ref.read(categoryProvider.notifier).getMyCategory();
    });

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            print("Working");
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCategory()));
          },
          child: Card(
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Create Category", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        home.myCategory.isEmpty? Expanded(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Center(child: Text("No Category Found!", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),)),
          ),
        ) : Expanded(
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: home.myCategory.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Card(
                      child: ListTile(
                        //tileColor: Colors.lightBlueAccent,
                        title: Text("${home.myCategory[index].name}", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
                        subtitle: Text("${home.myCategory[index].description}", style: TextStyle(fontSize: 18, overflow: TextOverflow.ellipsis)),
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
                          child: (home.myCategory[index].isDeleted == true? CircularProgressIndicator() : Icon(Icons.delete))
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
        ),
      ],
    );
  }
}
