import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {required this.labelText, required this.controller, Key? key, this.icon})
      : super(key: key);
  final String labelText;
  final TextEditingController controller;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
        style: TextStyle(
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.bold,
          fontSize: 22,
        ),
      decoration: InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(icon, size: 30,),
        labelText: labelText,
        labelStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey[400],
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }
}
