import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';


class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  @override
  String _input=" ";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
        centerTitle: true,
        backgroundColor: Colors.tealAccent,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              _input,
              style: TextStyle(
                fontSize: 40.0
              ),
            ),
          )
        ],
      ),
    );
  }
  void _handleButtonPressed(String value){
    setState(() {
      if(value=='='){
_calculateResult();
      }
      else if(value== 'c'){
    
      }
      else{
        _input +=value;
      }
    });
  }
  void _calculateResult(){
    try {
      // Using 'dart:math' to evaluate the expression
      var result = new Parser().parse(_input).evaluate(EvaluationType.REAL, ContextModel());
      _input = result.toString();
    } catch (e) {
      _input = 'Error';
    }
  }
  void _clearInput(){
    _input=" ";
  }
  }


class CalculatorKeypad extends StatelessWidget{
  // const CalculatorKeypad({super.key});
  final Function(String) onButtonPressed;
  CalculatorKeypad({required this.onButtonPressed});
    
  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        _buildrow(['AC','%','^','-']),
        _buildrow(['7','8','9','*']),
        _buildrow(['4','5','6','/']),
        _buildrow(['1','2','3','+']),
        _buildrow(['!','0','.','='])


      ],
    );
  }
  Widget _buildrow(List<String> buttons){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((button) => ElevatedButton(
                onPressed: () => onButtonPressed(button),
                child: Text(button),
              ))
          .toList(),
    );

  }
  }