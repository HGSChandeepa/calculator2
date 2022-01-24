import 'package:calculator_apk/buttons.dart';
import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color backColor = Color(0xff17D7A0);
  Color btnColor = Color(0xff544179);
  Color ansColor = Color(0xff6166B3);

  var userQuestion = "";
  var userAnswer = "0";

  final List<String> buttons = [
    "AC",
    "CE",
    "%",
    "/",
    "9",
    "8",
    "7",
    "x",
    "6",
    "5",
    "4",
    "-",
    "3",
    "2",
    "1",
    "+",
    "0",
    ".",
    "DEL",
    "="
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backColor,
      body: Column(
        children: [
          //top part

          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            color: ansColor,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(5, 40, 5, 5),
                    width: double.infinity,
                    child: Column(
                      children: [
                        Text(
                          userQuestion,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w900),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.1,
                        ),
                        Text(
                          userAnswer,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          //bottom part

          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            // color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.all(0),
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                ),
                itemCount: buttons.length,
                itemBuilder: (BuildContext context, int index) {
                  if (index == 0) {
                    return MyButton(
                      buttonColor: Colors.red,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(
                          () {
                            userQuestion = "";
                            userAnswer = "0";
                          },
                        );
                      },
                    );
                  } else if (index == 1) {
                    return MyButton(
                      buttonColor: Colors.grey,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(
                          () {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                            userAnswer = "0";
                          },
                        );
                      },
                    );
                  } else if (index == buttons.length - 2) {
                    return MyButton(
                      buttonColor: btnColor,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          if (userQuestion != "") {
                            userQuestion = userQuestion.substring(
                                0, userQuestion.length - 1);
                            userAnswer = "0";
                          } else {
                            userQuestion = "";
                            userAnswer = "";
                          }
                        });
                      },
                    );
                  } else if (index == buttons.length - 1) {
                    return MyButton(
                      buttonColor: btnColor,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(
                          () {
                            equalPressed();
                          },
                        );
                      },
                    );
                  } else {
                    return MyButton(
                      buttonColor: btnColor,
                      buttonText: buttons[index],
                      buttonTapped: () {
                        setState(() {
                          userQuestion += buttons[index];
                        });
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void equalPressed() {
    String finalQuestion = userQuestion;
    finalQuestion = finalQuestion.replaceAll('x', '*');

    Parser p = Parser();
    Expression exp = p.parse(finalQuestion);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    userAnswer = eval.toString();
  }
}
