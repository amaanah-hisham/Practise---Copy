import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StyledTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double width;
  final double height;

  const StyledTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.onChanged,
    this.validator,
    this.keyboardType,
    this.inputFormatters,
    this.width = double.infinity,
    this.height = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 450,
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Container(
          width: width, // Move width declaration here
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 5,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText,
            keyboardType: keyboardType,
            validator: validator,
            inputFormatters: inputFormatters,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.brown[500], fontWeight:FontWeight.w400),
              border: InputBorder.none, // To remove border line
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
            ),
          ),
        ),
      ),
    );
  }
}
