import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _input = " ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        actions: [
          Expanded(
            child: _buildIcon(Icons.menu, () {
              // Handle Menu icon press
              print('Menu icon pressed');
            }),
          ),
          Expanded(
            child: _buildIcon(Icons.search, () {
              // Handle Search icon press
              print('Search icon pressed');
            }),
          ),
          Expanded(
            child: _buildIcon(Icons.home, () {
              // Handle Home icon press
              print('Home icon pressed');
            }),
          ),
          Expanded(
            child: _buildIcon(Icons.history, () {
              // Handle History icon press
              print('History icon pressed');
            }),
          ),
        ],
      ),
      
      body: Column(
      
        children: [
          // SizedBox(height: 30,),
          Padding(
            padding: const EdgeInsets.all(80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  _input,
                  style: TextStyle(
                    fontSize: 40.0,
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Colors.black38,
          ),
          CalculatorKeypad(onButtonPressed: _handleButtonPressed),
        ],
      ),
    );
  }

  void _handleButtonPressed(String value) {
    setState(() {
      if (value == '=') {
        _calculateResult();
      } else if (value == 'AC') {
        _clearInput();
      } else if (value == '⌫') {
        _removeLastCharacter();
      } else {
        _input += value;
      }
    });
  }

  void _calculateResult() {
    try {
      var result = Parser().parse(_input).evaluate(EvaluationType.REAL, ContextModel());
      _input = result.toString();
    } catch (e) {
      _input = 'Error';
    }
  }

  void _clearInput() {
    _input = " ";
  }

  void _removeLastCharacter() {
    if (_input.isNotEmpty) {
      _input = _input.substring(0, _input.length - 1);
    }
  }

  Widget _buildIcon(IconData icon, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: IconButton(
        iconSize: 30,
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }
}

class CalculatorKeypad extends StatelessWidget {
  final Function(String) onButtonPressed;

  CalculatorKeypad({required this.onButtonPressed});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
    
        children: [
          _buildColumn(['AC', '⌫', '%', '/']),
          _buildColumn(['7', '8', '9', '*']),
          _buildColumn(['4', '5', '6', '-']),
          _buildColumn(['1', '2', '3', '+']),
          _buildColumn(['0', '.', '=']),
        ],
      ),
    );
  }

  Widget _buildColumn(List<String> buttons) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: buttons
            .map((button) => ElevatedButton(
                  onPressed: () => onButtonPressed(button),
                  style: ButtonStyle(
                    backgroundColor: button == '='
                        ? MaterialStateProperty.all<Color>(Colors.orange)
                        : MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  child: Text(
                    button,
                    style: TextStyle(
                      color: button == 'AC' || button == '⌫' || button == '%' || button == '/' || button == '*' || button == '+'
                          ? Colors.orange
                          : Colors.black,
                      fontSize: button == '*' || button == '+' || button == '=' ? 40 : 20,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}



// void main() {
//   runApp(CalculatorApp());
// }

// class CalculatorApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: CalculatorScreen(),
//     );
//   }
// }

// class CalculatorScreen extends StatefulWidget {
//   @override
//   _CalculatorScreenState createState() => _CalculatorScreenState();
// }

// class _CalculatorScreenState extends State<CalculatorScreen> {
//   String _input = '';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Calculator'),
//         centerTitle: true,
//         backgroundColor: Colors.teal,
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Text(
//               _input,
//               style: TextStyle(fontSize: 24),
//             ),
//           ),
//           CalculatorKeypad(onButtonPressed: _handleButtonPressed),
//         ],
//       ),
//     );
//   }

//   void _handleButtonPressed(String value) {
//     setState(() {
//       if (value == '=') {
//         _calculateResult();
//       } else if (value == 'C') {
//         _clearInput();
//       } else {
//         _input += value;
//       }
//     });
//   }

//   void _calculateResult() {
//     try {
//       // Using 'dart:math' to evaluate the expression
//       var result = new Parser().parse(_input).evaluate(EvaluationType.REAL, ContextModel());
//       _input = result.toString();
//     } catch (e) {
//       _input = 'Error';
//     }
//   }

//   void _clearInput() {
//     _input = '';
//   }
// }

// class CalculatorKeypad extends StatelessWidget {
//   final Function(String) onButtonPressed;

//   CalculatorKeypad({required this.onButtonPressed});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         _buildRow(['7', '8', '9', '/']),
//         _buildRow(['4', '5', '6', '*']),
//         _buildRow(['1', '2', '3', '-']),
//         _buildRow(['0', 'C', '=', '+']),
//       ],
//     );
//   }

//   Widget _buildRow(List<String> buttons) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: buttons
//           .map((button) => ElevatedButton(
//                 onPressed: () => onButtonPressed(button),
//                 child: Text(button),
//               ))
//           .toList(),
//     );
//   }
// }
