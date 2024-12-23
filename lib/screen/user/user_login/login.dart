import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/main.dart';
import 'package:networking_practice/screen/components/text_field_data.dart';
import 'package:networking_practice/screen/home_screen/home_page.dart';
import 'package:networking_practice/screen/user/user_category/category_controller.dart';
import 'package:networking_practice/screen/user/user_login/login_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/toast/toast_util.dart';
import '../user_register/register.dart';

class LogIn extends ConsumerStatefulWidget {
  const LogIn({super.key});

  @override
  ConsumerState<LogIn> createState() => _LogInState();
}

class _LogInState extends ConsumerState<LogIn> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final login = ref.watch(loginProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100),
              Center(child: Text("Hi, Welcome Back!", style: TextStyle(color: Colors.black, fontSize: 30, fontWeight: FontWeight.w800),)),
              SizedBox(height: 60),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Email", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
              TextFieldData(textData: _emailController, hintText: "Enter Your Email"),
              SizedBox(height: 30),
              Row(
                children: [
                  SizedBox(width: 5),
                  Text("Password", style: TextStyle(color: Colors.black, fontSize: 20,)),
                ],
              ),
              SizedBox(height: 5),
              TextFieldData(textData: _passwordController, hintText: "Enter Your Password"),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_box_outlined, size: 29,),
                      SizedBox(width: 3),
                      Text("Remember me", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                    ],
                  ),
                  Text("Forgot Password?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.red),),
                ],
              ),
              SizedBox(height: 50),
              GestureDetector(
                onTap: () async {
                  if(_emailController.text.isEmpty || _passwordController.text.isEmpty){
                    ToastUtil.showToast(context: context, message: "Fields can not be empty", isWarning: true);
                    return;
                  }
                  String? serverError = await ref.read(loginProvider.notifier).login(email: _emailController.text.trim(), password: _passwordController.text.trim());
          
                  if(serverError != null){
                    SharedPreferences prefs = await SharedPreferences.getInstance();
                    prefs.setString('token', serverError);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                  }else{
                    ToastUtil.showToast(context: context, message: "Error", isWarning: true);
                  }
                  print("Login Button Working");
                },
                child: Container(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),  // Corrected: Use `borderRadius` instead of `border`
                    color: Colors.blue,
                  ),
                  child: Center(child: login.isLoading? const CircularProgressIndicator() : Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                  SizedBox(width: 5),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Register()));
                      },
                      child: Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple),)
                  ),
                ],
              ),
              //Text("${_emailController.text}", style: TextStyle(fontSize: 40),),
            ],
          ),
        ),
      ),
    );
  }
}
