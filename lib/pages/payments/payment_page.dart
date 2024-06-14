import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class PaymentPage extends StatelessWidget {
  const PaymentPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BigText(title: "Administración de Pagos"),
      ),
      body: Center(
        child: Text("Informacion"),
      ),
    );
  }
}