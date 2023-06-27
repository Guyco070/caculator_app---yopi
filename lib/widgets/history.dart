import 'package:caculator_app/providers/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class History extends StatelessWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context) {
    final Calculator calculator = Provider.of<Calculator>(context);

    final List<String> reversedPrevList = calculator.prevValuesList.reversed.toList();

    return SizedBox(
      height: 250,
      width: double.maxFinite,
      child: calculator.prevValuesList.isEmpty
      ? const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
              "No history yet.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 25,
              ),
            ),
          Text(
              "Try my calculator first.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
        ],
      )
      : Column(
        children: [
          const Text(
              "History",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          const SizedBox(height: 10,),
          SizedBox(
            height: 160,
            child: ListView.builder(
              itemCount: reversedPrevList.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(2.0),
                child: Material(
                  elevation: 1,
                  color: Colors.blueGrey.shade100,
                  borderRadius: BorderRadius.circular(5),
                  child: ListTile(
                    title: Text(" ${reversedPrevList[index]}",)
                  ),
                ),
              ),
            ),
          ),
          TextButton(onPressed: calculator.clearHistory, child: const Text("Clear"))
        ],
      ),
    );
  }
}