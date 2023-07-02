import 'package:caculator_app/providers/calculator.dart';
import 'package:caculator_app/widgets/button.dart';
import 'package:flutter/material.dart';

class ButtonsGrid extends StatelessWidget {
  const ButtonsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 275,
      child: const CustomGridView()
    );
  }
}

class CustomGridView extends StatelessWidget {
  const CustomGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: extraActionValues.map((number) => Expanded(child: Button(value: number.toString()))).toList(), // %...
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...numbersValues.sublist(1,4).map((number) => Expanded(child: Button(value: number.toString()))), // 1..3
            Expanded(child: Button(value: actionsValues[0])), // x
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...numbersValues.sublist(4, 7).map((number) => Expanded(child: Button(value: number.toString()))), // 4..6
            Expanded(child: Button(value: actionsValues[1])), // /
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ...numbersValues.sublist(7, 10).map((number) => Expanded(child: Button(value: number.toString()))), // 7..9
            Expanded(child: Button(value: actionsValues[2])), // +
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Button(value: numbersValues[0].toString())), // 0
            ...actionsValues.sublist(3, 6).map((value) => Expanded(child: Button(value: value))), // ., =, -
          ],
        ),
      ],
    );
  }
}