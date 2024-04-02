import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  String hintText;
  TextEditingController controller;
   TextFieldWidget({

    super.key,
    required this.hintText,
    required this.controller,

  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: TextFormField(
        style: TextStyle(color: Colors.white),
        controller: controller,
        decoration: InputDecoration(
          hintStyle: TextStyle(color: Colors.grey),
          hintText: hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}