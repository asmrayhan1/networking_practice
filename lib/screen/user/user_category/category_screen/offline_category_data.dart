import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';

import '../../../../utils/toast/toast_util.dart';

class OfflineCategoryData extends ConsumerStatefulWidget {
  const OfflineCategoryData({super.key});

  @override
  ConsumerState<OfflineCategoryData> createState() => _OfflineCategoryDataState();
}

class _OfflineCategoryDataState extends ConsumerState<OfflineCategoryData> {
  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);
    return ListView.builder(
      shrinkWrap: true,
      itemCount: home.tmpCategory.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Card(
                color: Colors.cyan,
                child: ListTile(
                  //tileColor: Colors.lightBlueAccent,
                  title: Text("${home.tmpCategory[index].second.name}", style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w600)),
                  subtitle: Text(maxLines: 1, "${home.tmpCategory[index].second.description}", style: TextStyle(color: Colors.white, fontSize: 18, overflow: TextOverflow.ellipsis)),
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
