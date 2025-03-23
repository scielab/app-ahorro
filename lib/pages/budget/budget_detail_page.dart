import 'package:app/controllers/budget/budget_controller.dart';
import 'package:app/models/transaction_model.dart';
import 'package:app/utils/parse_utils.dart';
import 'package:app/widgets/common/text/big_text.dart';
import 'package:app/widgets/common/text/small_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BudgetDetailPage extends StatefulWidget {
  final String uid;
  final TransactionBase tb;
  const BudgetDetailPage({super.key,required this.uid,required this.tb});

  @override
  State<BudgetDetailPage> createState() => _BudgetDetailPageState();
}

class _BudgetDetailPageState extends State<BudgetDetailPage> {

  @override
  Widget build(BuildContext context) {
    final budgetController = Get.find<BudgetController>();
    final size = MediaQuery.of(context).size;
    
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: <Widget>[
          SliverAppBar(
            stretch: true,
            onStretchTrigger: () {
              // Function callback for stretch
              return Future<void>.value();
            },
            expandedHeight: 250.0,
            flexibleSpace: FlexibleSpaceBar(
              stretchModes: const <StretchMode>[
                StretchMode.zoomBackground,
                StretchMode.blurBackground,
                StretchMode.fadeTitle,
              ],
              centerTitle: true,
              background: Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      //gradient: LinearGradient(colors: [Colors.blue]),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 30,
                    right: 30,
                 
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BigText(title: '${formatNumberEnglish(widget.tb.amount.toString())} \$',size: 40,color: Colors.white,),
                        ],
                      ),
                    ),
                  
                ],
              ),
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0)
                  )
                ),
                child: Container(
                  width: 40.0,
                  height: 5.0,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(100.0),
                  ),
                ),
              ),

            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 30),
                child: const BigText(title: "Detalles de la Transaccion")),

              Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child: const Row(
                  children: [
                    SmallText(title: "Categoria"),
                    Spacer(),
                    SmallText(title: "1 en total"),
                  ],
                ),
              ),

              Container(
                margin: const EdgeInsets.only(left: 20,right: 20,bottom: 10),
                child: Row(
                  children: [
                    Column(
                      children: [
                        BigText(title: widget.tb.title),
                        const SmallText(title: "Date"),
                      ],
                    ),
                    const Spacer(),
                    SmallText(title: formatNumberEnglish(widget.tb.amount.toString())),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                width: size.width,
                height: 1,
                decoration: const BoxDecoration(
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 30,),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    // GestureDetector(
                    //   onTap: () {
                    //   },
                    //   child: Container(
                    //     width: size.width * 0.4,
                    //     height: 60,
                    //     decoration: BoxDecoration(
                    //       color: Colors.blue[700],
                    //       borderRadius: const BorderRadius.all(Radius.circular(10))
                    //     ),
                    //     child: const Center(
                    //       child: SmallText(title: "Actualizar",fw: FontWeight.bold,color: Colors.white,size: 20,),
                    //     ),
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: () {
                        if(widget.tb.uid != null) {
                          budgetController.deleteBudgetToFirebase(widget.tb.uid!);
                          Get.back();
                        }
                      },
                      child: Container(
                        width: size.width * 0.4,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.blue[700],
                          borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete,color: Colors.white,),
                            SizedBox(width: 10,),
                            SmallText(title: "Eliminar",fw: FontWeight.bold,color: Colors.white,size: 18,),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            ]),
          ),
        ],
      ),


    );
  }
}