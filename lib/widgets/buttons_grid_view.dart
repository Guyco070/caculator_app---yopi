import 'package:caculator_app/providers/calculator.dart';
import 'package:caculator_app/widgets/button.dart';
import 'package:flutter/material.dart';

class ButtonsGridView extends StatelessWidget {
  const ButtonsGridView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height - 275,
      child: GridView.count(
          crossAxisCount: 4,
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          padding: const EdgeInsets.all(15),
          children: [
            ...numbersValues.sublist(1,4).map((number) => Button(value: number.toString())), // 1..3
            Button(value: actionsValues[0]), // x

            ...numbersValues.sublist(4, 7).map((number) => Button(value: number.toString())), // 4..6
            Button(value: actionsValues[1]), // /

            ...numbersValues.sublist(7, 10).map((number) => Button(value: number.toString())), // 7..9
            Button(value: actionsValues[2]), // +

            Button(value: numbersValues[0].toString()),
            ...actionsValues.sublist(3, 6).map((value) => Button(value: value)), // ., =, -
          ]
        ),
    );
  }
}