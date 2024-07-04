import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintTextFor,
    required this.inputType,
  });

  final TextEditingController controller;
  final String hintTextFor;
  final TextInputType inputType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.5),
      child: TextField(
        keyboardType: inputType,
        controller: controller,
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(12),
            ),
            hintText: hintTextFor,
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xff004b23), width: 2),
              borderRadius: BorderRadius.circular(12),
            )),
      ),
    );
  }
}
