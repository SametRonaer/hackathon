import 'package:flutter/material.dart';

class AppTextfield extends StatelessWidget {
  
final String hintText;
final String label;
final TextEditingController textEditingController;
final TextInputType? inputType;

  const AppTextfield({super.key, 
   this.inputType,
  required this.hintText, required this.label, required this.textEditingController});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(label),
        ),
        TextField(
          keyboardType: inputType,
          controller: textEditingController,
          decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 14,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Color(0xFFE0E0E0), // hafif gri
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFBDBDBD), // focus olunca biraz daha koyu gri
            width: 1.2,
          ),
        ),
          ),
        ),
      ],
    );

  }
}