import 'package:flutter/material.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _output = "0";
  double _num1 = 0;
  double _num2 = 0;
  String _operand = "";
  String _currentInput = "";

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "+" || buttonText == "-" || buttonText == "*" || buttonText == "/") {
      _setOperand(buttonText);
    } else if (buttonText == "=") {
      _calculate();
    } else {
      _appendDigit(buttonText);
    }
  }

  void _clear() {
    setState(() {
      _output = "0";
      _num1 = 0;
      _num2 = 0;
      _operand = "";
      _currentInput = "";
    });
  }

  void _setOperand(String operand) {
    setState(() {
      if (_operand.isEmpty) {
        _num1 = double.parse(_output);
        _currentInput = "$_output $operand ";
        _operand = operand;
        _output = "0";
      }
    });
  }

  void _appendDigit(String digit) {
    setState(() {
      if (_output == "0") {
        _output = digit;
      } else {
        _output += digit;
      }
    });
  }

  void _calculate() {
    setState(() {
      if (_operand.isNotEmpty) {
        _num2 = double.parse(_output);
        switch (_operand) {
          case "+":
            _output = (_num1 + _num2).toString();
            break;
          case "-":
            _output = (_num1 - _num2).toString();
            break;
          case "*":
            _output = (_num1 * _num2).toString();
            break;
          case "/":
            if (_num2 != 0) {
              _output = (_num1 / _num2).toString();
            } else {
              _output = "Error";
            }
            break;
        }
        _currentInput = "";
        _operand = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculator App'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: EdgeInsets.all(16),
              child: Text(
                _currentInput.isEmpty ? _output : _currentInput,
                style: TextStyle(fontSize: 24),
              ),
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.black),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCalcButton("7"),
              _buildCalcButton("8"),
              _buildCalcButton("9"),
              _buildCalcButton("/"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCalcButton("4"),
              _buildCalcButton("5"),
              _buildCalcButton("6"),
              _buildCalcButton("*"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCalcButton("1"),
              _buildCalcButton("2"),
              _buildCalcButton("3"),
              _buildCalcButton("-"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              _buildCalcButton("C"),
              _buildCalcButton("0"),
              _buildCalcButton("="),
              _buildCalcButton("+"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCalcButton(String text) {
    return Container(
      padding: EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: () {
          _buttonPressed(text);
        },
        child: Text(
          text,
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
