import 'package:caculator_app/providers/calculator.dart';
import 'package:caculator_app/widgets/other/history.dart';
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

    return Expanded(
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: History()),
          Material(
            elevation: 5,
            borderRadius: BorderRadius.circular(borderRadius),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  IconButton(onPressed: calculator.deleteChar, 
                    icon: Icon(
                      Icons.backspace_outlined,
                      color: color.withOpacity(0.9),
                    )),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: Text(
                      calculator.value ?? hintText,
                      style: TextStyle(
                        fontSize: 18,
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
            ),
          const SizedBox(height: 10,)
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
      ),);
  }
}