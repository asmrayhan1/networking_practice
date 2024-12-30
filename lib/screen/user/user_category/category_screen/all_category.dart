import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';
import 'package:networking_practice/screen/user/user_category/category_screen/get_category_data.dart';
import 'package:networking_practice/screen/user/user_category/create_category.dart';
import 'package:networking_practice/screen/user/user_category/update_category.dart';
import 'package:networking_practice/utils/toast/toast_util.dart';

import '../../../components/custom_container.dart';
import 'offline_category_data.dart';

class AllCategory extends ConsumerStatefulWidget {
  const AllCategory({super.key});

  @override
  ConsumerState<AllCategory> createState() => _State();
}

class _State extends ConsumerState<AllCategory> {
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

      ref.read(categoryProvider.notifier).getMyCategory();
      ref.read(categoryProvider.notifier).getOfflineData();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final home = ref.watch(categoryProvider);
    return Column(
      children: [
        SizedBox(height: 10,),
        GestureDetector(
          onTap: (){
            print("Working");
            _internet? ToastUtil.showToast(context: context, message: "No internet connection found!") : Navigator.push(context, MaterialPageRoute(builder: (context) => CreateCategory()));
          },
          child: Card(
            child: ListTile(
              leading: Icon(Icons.add_circle_outline),
              title: Text("Create Category", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600)),
            ),
          ),
        ),
        _internet? home.tmpCategory.isEmpty? CustomContainer(message: "No Category Found") : OfflineCategoryData()
            : home.myCategory.isEmpty? CustomContainer(message: "No Category Found!") : GetCategoryData()
      ],
    );
  }
}
