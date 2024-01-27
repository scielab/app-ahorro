import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final bool isPassword;

  const InputField(
      {super.key, required this.controller, required this.labelText,this.isPassword = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
      obscureText: isPassword,
      decoration:  InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(23, 23, 23, 1),
        focusedBorder: InputBorder.none,
        contentPadding: const EdgeInsets.all(10),
        border: OutlineInputBorder( // Establece un borde redondeado
            borderRadius: BorderRadius.circular(10.0), // Radio del borde
            borderSide: BorderSide.none, // Quita el borde por defecto
        ),
        labelStyle: const TextStyle(
            color: Color.fromARGB(255, 243, 243, 243),
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
