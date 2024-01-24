
import 'package:app/widgets/bottomNavigatorBar.dart';
import 'package:app/widgets/button_base.dart';
import 'package:app/widgets/button_base_drop.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu,size: 28,),
        actions: [
          Container(
            margin: EdgeInsets.only(right: 14),
            child: Icon(Icons.notifications,size: 28,),
          )
        ],
        title: const Center(child: Text("total valance",style: TextStyle(color: Colors.black),),)
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: const Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonBase(title: "Expenses",primary: true,),
                ButtonBase(title: "Income"),
                ButtonBaseDrop(title: "June"),
              ],
            )
          ],
        ),
      ),
      bottomNavigationBar: const ButtonNavigatorBarPrimary(),
    );
  }
}