import 'package:caculator_app/providers/calculator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Button extends StatelessWidget {
  const Button({super.key, required this.value,});
  final String value;

  List<Color?> getColors(BuildContext context){
    final Color bgColor = Theme.of(context).colorScheme.background.withOpacity(0.5);
    final Color primaryColor = Theme.of(context).colorScheme.primary;

    if(int.tryParse(value) != null) return [bgColor, primaryColor, null];
    switch(value){
      case "=": return [Colors.orange[700], Colors.orange[900]!, Colors.white];
      case ".": return [bgColor, Colors.blueAccent, Colors.blue[900]];
      default: return [Colors.black87, primaryColor, Colors.white];
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color borderColor =  Colors.black45;

    late final double size = MediaQuery.of(context).size.width / 4.6;
    
    final List<Color?> colors = getColors(context);
    final Color fillColor = colors[0]!;
    final Color splashColor = colors[1]!;
    final Color? textColor = colors[2];
  

    return Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: fillColor,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: borderColor)
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(30),
            splashColor: splashColor,
            onTap: () => Provider.of<Calculator>(context, listen: false).calculate(value, context),
            child: Center(
              child: Text(
                  value,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
            ),
          ),
        ),
      ),
    );
  }
}