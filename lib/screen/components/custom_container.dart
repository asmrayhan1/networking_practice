import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final String message;
  const CustomContainer({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(child: Text("${message}", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black38),)),
      ),
    );
  }
}
