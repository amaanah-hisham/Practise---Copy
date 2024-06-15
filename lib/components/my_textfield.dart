import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import TextInputFormatter

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final TextInputType? inputType;
  final List<TextInputFormatter>? inputFormatters; // New parameter for input formatters

  const MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.validator,
    this.inputType,
    this.inputFormatters, // Optional input formatters
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: inputType,
        validator: validator,
        inputFormatters: inputFormatters, // Set input formatters
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade100),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.brown.shade300),
            borderRadius: BorderRadius.circular(30),
          ),
          contentPadding: EdgeInsets.only(left: 20, top: 20, bottom: 20),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.brown[400]),
        ),
      ),
    );
  }
}