import 'package:caculator_app/providers/calculator.dart';
import 'package:caculator_app/widgets/history.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.hintText,
    {
    super.key,
    this.keyboardType,
  });

  final String hintText;
  final TextInputType? keyboardType;

  final double borderRadius = 12;

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final Calculator calculator = Provider.of<Calculator>(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8),
      child: Column(
        children: [
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Container(
              width: double.maxFinite - 20,
              height: 60,
              decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    border: Border.all(
                          color: color,
                          width: 2.0,
                        )
                  ),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(onPressed: calculator.deleteChar, 
                            icon: Icon(
                              Icons.backspace_outlined,
                              color: color.withOpacity(0.9),
                            )),
                          Center(
                            child: Text(
                              calculator.value ?? hintText,
                              style: TextStyle(
                                fontSize: 16,
                                color: calculator.value == null ? color.withOpacity(0.7) : color,
                                fontWeight: FontWeight.w500
                              ),
                            ),
                          ),
                          IconButton(onPressed: calculator.clearValue, 
                            icon: Icon(
                              Icons.clear,
                              color: color.withOpacity(0.9),
                            ))
                        ],
                      ),
                    ],
                  ),
            ),
          ),
              TextButton(
                  onPressed: () {
                    calculator.toggleHistoryExpanded();
                    dialogBox(context);
                  },
                  child: const Text("History")
                ),
        ],
      ),
    );
  }
  
  void dialogBox(BuildContext context) {
    showDialog(context: context, builder: (context) => const AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20.0))
        ),
        content: History(),
            // actions: widget.actions,
      ),);
  }
}