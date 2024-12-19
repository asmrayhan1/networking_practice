import 'package:flutter/material.dart';

class TextFieldData extends StatelessWidget {
  final String hintText;
  TextEditingController textData = TextEditingController();
  TextFieldData({super.key, required this.textData, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textData,
      maxLines: 1,
      maxLength: 40,
      decoration: InputDecoration(
        counter: Offstage(),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12.0)),  // Rounded corners
        ),
        hintText: "${hintText}",
        hintStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
      ),
      style: TextStyle (
          fontSize: 20
      ),
      onTap: (){
        //UnfocusDispositio
      },
    );
  }
}
