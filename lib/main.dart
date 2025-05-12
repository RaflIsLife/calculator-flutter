import 'dart:math';
import 'package:flutter/material.dart';
import 'package:expressions/expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Calculator'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;

  const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String number = '';
  String tempNumber = '';
  String pressedNumber = '';
  String finalNumber = '';

  calculating() {
    if (number.isEmpty) {
      return finalNumber = '';
    } else {
      if (![
        '/',
        '+',
        '-',
        'x',
      ].contains(number.replaceRange(0, number.length - 1, ''))) {
        tempNumber = number.replaceAll('x', '*');
        tempNumber = tempNumber.replaceAll('%', '/100');
        Expression expression = Expression.parse(tempNumber);

        var context = {"cos": cos, "sin": sin};

        final evaluator = const ExpressionEvaluator();
        var finalNumber = evaluator.eval(expression, context);

        return finalNumber.toString();
      } else {
        return finalNumber;
      }
    }
  }

  addNumber(pressedNumber) {
    if (number.isEmpty || number == '-') {
      if (number == '-' && pressedNumber == '-') {
      } else if (pressedNumber != '/' &&
          pressedNumber != 'x' &&
          pressedNumber != '+') {
        number += pressedNumber;
        print('masuk ke sini 1');
      } else {
        number = '';
        print('masuk ke sini 2');
      }
      //validasi operator agar tidak numpuk
    } else if ((number.endsWith("/") || number.endsWith("x")) &&
        pressedNumber == "-") {
      number += pressedNumber;
      print('masuk ke sini 3');
    } else if ((number.endsWith("/") ||
            number.endsWith("x") ||
            number.endsWith("+") ||
            number.endsWith("-")) &&
        number != "-") {
      if (number.endsWith("-") &&
          (pressedNumber == "/" ||
              pressedNumber == "x" ||
              pressedNumber == "+")) {
        // Tidak mengganti "-" dengan operator lain
        print('Operator tidak valid setelah "-"');
      } else if (pressedNumber == "/" ||
          pressedNumber == "x" ||
          pressedNumber == "+" ||
          pressedNumber == "-") {
        number = number.substring(0, number.length - 1);
        number += pressedNumber;
        print('masuk ke sini 4');
      } else {
        number += pressedNumber;
        print('masuk ke sini 5');
      }
    } else {
      number += pressedNumber;
      print('masuk ke sini 6');
    }

    setState(() {
      number;
    });

    if (number.contains('/') ||
        number.contains('x') ||
        number.contains('+') ||
        number.contains('-') ||
        number.contains('%')) {
      setState(() {
        finalNumber = calculating();
      });
    }
  }

  removeAllNumber() {
    setState(() {
      number = '';
      pressedNumber = '';
      finalNumber = '';
    });
  }

  removeOneNumber() {
    if (number.isNotEmpty) {
      setState(() {
        number = number.substring(0, number.length - 1);
        if (number.contains('/') ||
            number.contains('x') ||
            number.contains('+') ||
            number.contains('-')) {
          finalNumber = calculating();
        } else {
          finalNumber = '';
        }
      });
    }
  }

  hitEqualButton() {
    setState(() {
      number = finalNumber;
      finalNumber = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Container(
              alignment: Alignment.bottomRight,
              padding: const EdgeInsets.only(bottom: 28, right: 20),
              width: double.infinity,
              color: Colors.black,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 3,
                children: [
                  Text(
                    number,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    finalNumber,
                    style: TextStyle(
                      color: Colors.white38,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              color: Colors.black87,
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      //button: C, /, X, <=
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            label: 'C',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '/',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: 'x',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '<=',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //button: 7, 8, 9, -
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            label: '7',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '8',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '9',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '-',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      //button: 4, 5, 6, +
                      children: [
                        Expanded(
                          child: CalculatorButton(
                            label: '4',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '5',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '6',
                            color: Colors.white,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                        Expanded(
                          child: CalculatorButton(
                            label: '+',
                            color: Colors.blue,
                            addNumber: addNumber,
                            removeAllNumber: removeAllNumber,
                            removeOneNumber: removeOneNumber,
                            hitEqualButton: hitEqualButton,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Column(
                            children: [
                              Expanded(
                                child: Row(
                                  //button: 1, 2, 3
                                  children: [
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '1',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '2',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '3',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  //button: %, 0, .
                                  children: [
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '%',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '0',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                    Expanded(
                                      child: CalculatorButton(
                                        label: '.',
                                        color: Colors.white,
                                        addNumber: addNumber,
                                        removeAllNumber: removeAllNumber,
                                        removeOneNumber: removeOneNumber,
                                        hitEqualButton: hitEqualButton,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.lightBlue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: CalculatorButton(
                                label: '=',
                                color: Colors.white,
                                addNumber: addNumber,
                                removeAllNumber: removeAllNumber,
                                removeOneNumber: removeOneNumber,
                                hitEqualButton: hitEqualButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CalculatorButton extends StatelessWidget {
  final String label;
  final Color color;
  final Function addNumber;
  final Function removeAllNumber;
  final Function removeOneNumber;
  final Function hitEqualButton;

  const CalculatorButton({
    super.key,
    required this.label,
    required this.color,
    required this.addNumber,
    required this.removeAllNumber,
    required this.removeOneNumber,
    required this.hitEqualButton,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(Colors.transparent),
          elevation: WidgetStatePropertyAll(0),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          ),
          visualDensity: VisualDensity(horizontal: 2, vertical: 2),
        ),
        onPressed: () {
          if (label == '=') {
            hitEqualButton();
          } else if (label == 'C') {
            removeAllNumber();
          } else if (label == '<=') {
            removeOneNumber();
          } else {
            addNumber(label);
          }
        },
        child: Text(label, style: TextStyle(color: color, fontSize: 32)),
      ),
    );
  }
}
