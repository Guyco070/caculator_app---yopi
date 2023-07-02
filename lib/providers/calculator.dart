import 'dart:math';

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

final List<String> extraActionValues = [
  "%",
  "√"
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
    final int? lastValTPI = double.tryParse(last)?.toInt();
    last = lastValTPI != null && lastValTPI == double.parse(last) ? lastValTPI.toString() : last;
    last = last.substring(0, last.length-1);

    inputeValues.removeLast();

    final double? lastValTPB = double.tryParse(last);

    if(lastValTPB != null){
      inputeValues.add(last);
    }

    if(inputeValues.isEmpty){
      clearValue();
      return;
    } 

    final subString = value!.substring(0, value!.length-1);
    value = subString.isEmpty ? null : subString;
    notifyListeners();
  }

  calculate(String newValue, BuildContext context){
    print("calc $inputeValues");
    if(newValue == "%" && inputeValues.lastOrNull == "√") return;

    final double? newValTP = double.tryParse(newValue);
    
    if(newValTP != null){
      value = (value ?? "") + newValue;
      prevValue = value;

      dynamic last = inputeValues.lastOrNull;

      if(last is double){
        inputeValues.removeLast();
        inputeValues.add(double.parse(fixeAfterDot(last.toString(), 0).toString() + newValue));
      } else {
        if(last == null || actionsValues.contains(last) || last == "√"){
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

      if(inputeValues.last is String && inputeValues.last != "%" && (inputeValues.last != "√" || newValue == "-")) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(!(inputeValues.last != "√" || newValue == "-") 
                                      ?"An action cannot be performed on an action"
                                      : "Can not use this action on negative value"
                                    )));
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
      

      if(inputeValues.length > 1 && inputeValues[inputeValues.length - 2] == "√") {
        final int squareRootIndex = inputeValues.indexOf("√");

        double sqrtVal = sqrt(inputeValues[squareRootIndex + 1]);
        inputeValues.removeLast();
        inputeValues.add(sqrtVal);

        value = value!.substring(0, squareRootIndex == -1 ? 0 : squareRootIndex) + fixeAfterDot(inputeValues.last.toString(), 4);
        if(newValue == "=") {
          inputeValues.clear();
          inputeValues.add(double.parse(value!));
          notifyListeners();
          return;
        }
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

        late final int presIndex;
        presIndex = inputeValues.indexOf("%");
        if(presIndex != -1){
          switch(presIndex) {
            case 1: inputeValues[0] = inputeValues[0] * (inputeValues[3] / 100); 
            break;
            case 3: inputeValues[2] = inputeValues[2] * (inputeValues[0] / 100); 
            break;
          }
          inputeValues.removeAt(presIndex);
        }

        switch(inputeValues[1]) {
          case "x": value = (inputeValues[0] * inputeValues[2]).toString();
            break;
          case "/": 
            if(inputeValues[2] == 0) {
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error - cannot divide at 0 (Infinity)")));
              return;
            }
            value = (inputeValues[0] / inputeValues[2]).toString();
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

  void squareRootAction(String newValue) {
    final int squareRootIndex = inputeValues.indexOf("√");
    
    double sqrtVal = sqrt(inputeValues[squareRootIndex + 1]);
    inputeValues.add(double.parse(fixeAfterDot(sqrtVal.toString(), 4)));
    
    if(newValue == "=" && inputeValues.length <= 2) {
      value = value!.substring(0, squareRootIndex == -1 ? 0 : squareRootIndex) + fixeAfterDot(sqrtVal.toString(), 4);
      prevValuesList.add("√${fixeAfterDot(inputeValues[squareRootIndex + 1].toString(), 4)} = ${fixeAfterDot(sqrtVal.toString(), 4)}");
    } else {
      value = value!.substring(0, squareRootIndex == -1 ? 0 : squareRootIndex) + newValue + fixeAfterDot(inputeValues.last.toString(), 4);
    }    
    inputeValues.removeRange(squareRootIndex, squareRootIndex + 2);
  }

  String fixeAfterDot(String value, int number){
      final List<String> splited = value.split(".");
      final String remainder = splited[1];
      
      if(number == 0 || remainder == "0") {
        if(int.parse(remainder) != 0) return value;

        return double.parse(value).toInt().toString();
      }

      return "${splited[0]}.${remainder.substring(0, remainder.length < number ? remainder.length : number)}";
    }
}