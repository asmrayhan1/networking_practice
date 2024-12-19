import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:networking_practice/screen/components/text_field_data.dart';
import 'package:networking_practice/screen/user/user_register/register_controller.dart';
import 'package:networking_practice/utils/toast/toast_util.dart';

import '../user_login/login.dart';

class Register extends ConsumerStatefulWidget {
  const Register({super.key});

  @override
  ConsumerState<Register> createState() => _RegisterState();
}

class _RegisterState extends ConsumerState<Register> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final register = ref.watch(registerProvider);
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 100),
            Center(child: Text("Create an account", style: TextStyle(color: Colors.black, fontSize: 28, fontWeight: FontWeight.w800),)),
            Center(child: Text("Connect with your friends today!", style: TextStyle(color: Colors.black, fontSize: 20),)),
            SizedBox(height: 50),
            TextFieldData(textData: _emailController, hintText: "Enter Your Email"),
            SizedBox(height: 30),
            TextFieldData(textData: _passwordController, hintText: "Enter Your Password"),
            SizedBox(height: 30),
            TextFieldData(textData: _confirmPasswordController, hintText: "Confirm Your Password"),
            SizedBox(height: 50),
            GestureDetector(
              onTap: ()async{
                if(_emailController.text.isEmpty || _passwordController.text.isEmpty || _confirmPasswordController.text.isEmpty){
                  ToastUtil.showToast(context: context, message: "Fields can not be empty", isWarning: true);
                  return;
                }
                if (_passwordController.text.trim() != _confirmPasswordController.text.trim()){
                  ToastUtil.showToast(context: context, message: "Confirm Password Did not match", isWarning: true);
                  return;
                }

                String? serverError = await ref.read(registerProvider.notifier).signup(email: _emailController.text.trim(), password: _passwordController.text.trim(), confirmPassword: _confirmPasswordController.text.trim());

                if(serverError==null){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
                }else{
                  ToastUtil.showToast(context: context, message: serverError, isWarning: true);
                }
              },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),  // Corrected: Use `borderRadius` instead of `border`
                  color: Colors.blue,
                ),
                child: Center(child: register.isLoading?const CircularProgressIndicator(): Text("Sign Up", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 23, color: Colors.white))),
              ),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account?", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),),
                SizedBox(width: 5),
                GestureDetector(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LogIn()));
                    },
                    child: Text("Login", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: Colors.deepPurple),)
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
