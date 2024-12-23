import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/home_screen/home_page.dart';
import 'package:networking_practice/screen/user/user_login/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

String? token;
late SharedPreferences prefs;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  prefs = await SharedPreferences.getInstance();
  token = prefs.getString('token');
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: (token == null ? const LogIn() : HomePage()),
      //home: TestScreen(),
    );
  }
}