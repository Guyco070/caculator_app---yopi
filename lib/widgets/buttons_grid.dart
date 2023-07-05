import 'package:caculator_app/providers/calculator.dart';
import 'package:caculator_app/widgets/button.dart';
import 'package:flutter/material.dart';

class ButtonsGrid extends StatelessWidget {
  const ButtonsGrid({super.key});

    @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          buttonsRow(extraActionValues), // %, √
          buttonsRow([...numbersValues.sublist(1,4), actionsValues[0]]), // 1...3, x
          buttonsRow([...numbersValues.sublist(4,7), actionsValues[1]]), // 4...6, /
          buttonsRow([...numbersValues.sublist(7,10), actionsValues[2]]), // 7...9, +
          buttonsRow([numbersValues[0], ...actionsValues.sublist(3,6)]), // 0, ., =, -
        ],
      ),
    );
  }

  Row buttonsRow(List<dynamic> buttons) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons.map((button) => Expanded(child: Button(value: button.toString()))).toList()
      );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
  
    return Column(
      children: [
        buttonsRow(extraActionValues), // %, √
        buttonsRow([...numbersValues.sublist(1,4), actionsValues[0]]), // 1...3, x
        buttonsRow([...numbersValues.sublist(4,7), actionsValues[1]]), // 4...6, /
        buttonsRow([...numbersValues.sublist(7,10), actionsValues[2]]), // 7...9, +
        buttonsRow([numbersValues[0], ...actionsValues.sublist(3,6)]), // 0, ., =, -
      ],
    );
  }

  Row buttonsRow(List<dynamic> buttons) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: buttons.map((button) => Expanded(child: Button(value: button.toString()))).toList()
      );
  }
}