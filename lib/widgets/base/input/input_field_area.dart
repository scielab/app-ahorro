import 'package:flutter/material.dart';

class InputFieldArea extends StatelessWidget {
  final TextEditingController controller;
  const InputFieldArea({super.key,required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Color.fromARGB(255, 230, 230, 230),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.multiline,
          minLines: 1,
          maxLines: 5,
          decoration: const InputDecoration( 
              hintText: "Escriba el Mensaje",
              border: InputBorder.none,
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide.none,
              )
          ),
        ),
      ),
    );
  }
}