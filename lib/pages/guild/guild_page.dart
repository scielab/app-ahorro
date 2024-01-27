import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class GuildPage extends StatelessWidget {
  const GuildPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Perfil"),
      ),
      body: const Center(
        child: Text("hola"),
      ),
    );
  }
}