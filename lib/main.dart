import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String input = "";
  String result = "";

  void onPressed(String value) {
    setState(() {
      if (value == "C") {
        input = "";
        result = "";
      } else if (value == "=") {
        try {
          String expression = input;

          expression = expression.replaceAll('×', '*');
          expression = expression.replaceAll('÷', '/');

          result = _calculate(expression).toString();
        } catch (e) {
          result = "Error";
        }
      } else {
        input += value;
      }
    });
  }

  double _calculate(String expression) {
    List<String> numbers = expression.split(RegExp(r'[+\-*/]'));
    List<String> ops = expression.replaceAll(RegExp(r'[0-9.]'), '').split('');

    double total = double.parse(numbers[0]);

    for (int i = 0; i < ops.length; i++) {
      double num = double.parse(numbers[i + 1]);

      switch (ops[i]) {
        case '+':
          total += num;
          break;
        case '-':
          total -= num;
          break;
        case '*':
          total *= num;
          break;
        case '/':
          total /= num;
          break;
      }
    }

    return total;
  }

  Widget button(String text, Color color) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: color,
            padding: const EdgeInsets.all(20),
          ),
          onPressed: () => onPressed(text),
          child: Text(text, style: const TextStyle(fontSize: 22)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    input,
                    style: const TextStyle(fontSize: 32, color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    result,
                    style: const TextStyle(fontSize: 40, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),

          Row(
            children: [
              button("7", Colors.grey),
              button("8", Colors.grey),
              button("9", Colors.grey),
              button("÷", Colors.orange),
            ],
          ),
          Row(
            children: [
              button("4", Colors.grey),
              button("5", Colors.grey),
              button("6", Colors.grey),
              button("×", Colors.orange),
            ],
          ),
          Row(
            children: [
              button("1", Colors.grey),
              button("2", Colors.grey),
              button("3", Colors.grey),
              button("-", Colors.orange),
            ],
          ),
          Row(
            children: [
              button("C", Colors.red),
              button("0", Colors.grey),
              button("=", Colors.green),
              button("+", Colors.orange),
            ],
          ),
        ],
      ),
    );
  }
}
