import 'package:flutter/material.dart' hide Action;

final List<int> numbersValues = List.generate(10, (index) => index);

final List<String> actionsValues = [
    "x",
    "/",
    "+",
    ".",
    "=",
    "-",
  ];

class Calculator with ChangeNotifier {
  String? value;
  String? prevValue;
  final List<String> prevValuesList = [];
  final List<dynamic> inputeValues = [];

  bool isHistoryExpanded = false;

  toggleHistoryExpanded() {
    isHistoryExpanded = !isHistoryExpanded;
    notifyListeners();
  }

  updateValue(String newValue){
    value = (value ?? "") + newValue;
    prevValue = value;
    notifyListeners();
  }

  clearValue(){
    value = null;
    prevValue = null;
    inputeValues.clear();
    notifyListeners();
  }

  clearHistory(){
    prevValuesList.clear();
    notifyListeners();
  }

  deleteChar(){
    if(value == null) return;
    String last = inputeValues.last.toString();
    last = last.substring(0, last.length-1);

    inputeValues.removeLast();

    final double? lastValTP = double.tryParse(last);

    if(lastValTP != null){
      inputeValues.add(last);
    }

    final subString = value!.substring(0, value!.length-1);
    value = subString.isEmpty ? null : subString;
    notifyListeners();
  }

  calculate(String newValue, BuildContext context){
    final double? newValTP = double.tryParse(newValue);
    
    if(newValTP != null){
      value = (value ?? "") + newValue;
      prevValue = value;

      dynamic last = inputeValues.lastOrNull;

      if(last is double){
        inputeValues.removeLast();
        inputeValues.add(double.parse(fixeAfterDot(last.toString(), 0).toString() + newValue));
      } else {
        if(last == null || actionsValues.contains(last)){
          inputeValues.add(newValTP);
        } else {
          inputeValues.removeLast();
          inputeValues.add(double.parse(last + newValue));
        }
      }
      
      notifyListeners();
      return;
    } else {

      // in case of an action inpute
      if(inputeValues.isEmpty) return;

      if(inputeValues.last is String) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("An action cannot be performed on an action ")));
        return;
      }

      if(newValue == "."){
        if(inputeValues.lastOrNull is! double) return;
        
        int intVal = (inputeValues.last as double).toInt();
        value = value! + newValue;
      
        inputeValues.removeLast();
        inputeValues.add(intVal.toString() + newValue);
        
        notifyListeners();
        return;
      }

      // in case only 1 number is included
      if(inputeValues.length < 3) {
        if(newValue == "=") return;

        value = value! + newValue;
        prevValue = value;

        inputeValues.add(newValue);
        notifyListeners();
        return;
      } else {
        switch(inputeValues[1]) {
          case "x": value = (inputeValues[0] * inputeValues[2]).toString();
            break;
          case "/": value = (inputeValues[0] / inputeValues[2]).toString();
            break;
          case "+": value = (inputeValues[0] + inputeValues[2]).toString();
            break;
          case "-": value = (inputeValues[0] - inputeValues[2]).toString();
            break;
          default: break;
        }
        
        int intVal = double.parse(value!).toInt();
        
        if(intVal == double.parse(value!)){
          // fix to int
          value =  intVal.toString();
        } else {
          // fix to 4 numbers after .
          value = fixeAfterDot(value!, 4);
        }

        prevValuesList.add("${prevValue!} = ${value!}");

        inputeValues.clear();
        inputeValues.add(double.parse(value!));

        if(newValue != "="){
          value = value! + newValue;
          inputeValues.add(newValue);
        }

        notifyListeners();
      }

    }
  }

  String fixeAfterDot(String value, int number){
      final List<String> splited = value.split(".");
      final String remainder = splited[1];
      
      if(number == 0) {
        if(int.parse(remainder) != 0) return value;

        return double.parse(value).toInt().toString();
      }

      return "${splited[0]}.${remainder.substring(0, remainder.length < number ? remainder.length : number)}";
    }
}