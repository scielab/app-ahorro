import 'package:app/widgets/big_text.dart';
import 'package:flutter/material.dart';

class CalculatorWidget extends StatefulWidget {
  final TextEditingController valueController;
  final VoidCallback onPressed;

  CalculatorWidget({super.key,required this.valueController,required this.onPressed});

  @override
  State<CalculatorWidget> createState() => _CalculatorWidgetState();
}

class _CalculatorWidgetState extends State<CalculatorWidget> {
  final List<String> buttons = [
    '1','2','3','DEL',
    '4','5','6','D',
    '7','8','9','C',
    '\$','0',',','OK'
  ];

  @override
  Widget build(BuildContext context) {
      return Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        height: MediaQuery.of(context).size.height * 0.45,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4), 
          itemBuilder: (BuildContext context, index) {
            if(isOkButton(index)) {
              return GestureDetector(
                onTap: widget.onPressed,
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: BigText(title: buttons[index],size: 26,color: Colors.white,)
                  )
                ),
              );
            } else if (isOtherButton(index)) {
              return GestureDetector(
                onTap: () {
                  if(buttons[index] == 'DEL') {
                    setState(() {
                      widget.valueController.text = "";
                    });
                  } else if (buttons[index] == 'C' && widget.valueController.text != "") {
                    widget.valueController.text = widget.valueController.text.substring(0,widget.valueController.text.length-1);
                  }

                },
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 143, 143),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: BigText(title: buttons[index],size: 26)
                  )
                ),
              );
            } else {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    widget.valueController.text += buttons[index];
                  });
                },
                child: Container(
                  margin: const EdgeInsets.all(1),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: BigText(title: buttons[index],size: 26)
                  )
                ),
              );
            }
          },
          itemCount: buttons.length,
        ),
      );
  }

  bool isOkButton(int index) => buttons[index] == 'OK' ? true : false;

  bool isOtherButton(int index) {
    String buttonSelect = buttons[index];
    if(buttonSelect == 'DEL' || buttonSelect == 'C' || buttonSelect == 'D') {
      return true;
    }
    return false;
  }
}