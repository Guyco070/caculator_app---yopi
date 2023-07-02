import 'package:caculator_app/providers/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final Calculator calculator = Provider.of<Calculator>(context);

    final List<String> reversedPrevList = calculator.prevValuesList.reversed.toList();

    final Color color = Theme.of(context).colorScheme.primary;

    return SizedBox(
      height: 250,
      width: double.maxFinite,
      child: calculator.prevValuesList.isEmpty
      ? Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "No history yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 18,
                color: color.withOpacity(0.7),
              ),
            ),
          Text(
              "Try my calculator first.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: color.withOpacity(0.7),
              ),
            ),
        ],
      )
      : SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: reversedPrevList.map((e){
                final List<String> seperated = e.split(" ");
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Material(
                    elevation: 1,
                    color: Colors.blueGrey.shade100,
                    borderRadius: BorderRadius.circular(5),
                    child: ListTile(
                      title: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: seperated[0],
                              style: TextStyle(
                                fontSize: 15,
                                color: color
                              ),
                            ),
                            TextSpan(
                              text: " = ${seperated[2]}",
                              style: TextStyle(
                                fontSize: 15,
                                color: color,
                                fontWeight: FontWeight.bold
                              ),
                            )
                          ]
                        )
                      )
                    ),
                  ),
                );
              }).toList(),
            ),
            TextButton(onPressed: calculator.clearHistory, child: const Text("Clear History"))
          ],
        ),
      ),
    );
  }
}