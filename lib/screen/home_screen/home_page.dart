import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/main.dart';
import 'package:networking_practice/screen/home_screen/all_collection.dart';
import 'package:networking_practice/screen/user/user_category/category_screen/all_category.dart';
import 'package:networking_practice/screen/user/user_task/task_screen/all_task.dart';
import 'package:networking_practice/screen/user_profile/profile.dart';

import '../user/user_login/login.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      print("index = ${index}");
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    AllCollection(),
    AllTask(),
    AllCategory(),
    Profile()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: Text("Networking", style: TextStyle(color: Colors.white),),
        actions: [
          // Padding(
          //   padding: const EdgeInsets.only(right: 15),
          //   child: GestureDetector(
          //       onTap: (){
          //         Navigator.push(context, MaterialPageRoute(builder: (context) => Category()));
          //       },
          //       child: Icon(Icons.widgets_outlined, color: Colors.white,)
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: GestureDetector(
              onTap: () async {
                await prefs.remove('token');
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
              },
                child: Icon(Icons.logout, color: Colors.white,)
            ),
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex), backgroundColor: Color(0xff547D86),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex, // This will keep track of the selected index
        onTap: _onItemTapped, // Function to handle tap events

        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.blueGrey,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54,
        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
          color: Colors.blue,  // Change text color for the selected label
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        // unselectedLabelStyle: TextStyle(
        //   color: Colors.black,  // Change text color for the unselected label
        //   fontWeight: FontWeight.normal,
        //   fontSize: 12,
        // ),
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.post_add_sharp),
            label: 'Task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.widgets_outlined),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
