import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:learnwithseries/models/question.dart';

class QuizAnswer extends StatefulWidget {
  final Question question;
  final Function incrementQuestion;

  QuizAnswer({Key key, this.question, this.incrementQuestion})
      : super(key: key);

  @override
  _QuizAnswerState createState() => _QuizAnswerState();
}

class _QuizAnswerState extends State<QuizAnswer> {
  String correctAnswer;
  int answerIndex = -1;
  int correctIndex = -1;
  Color answerColor;
  bool isClicked = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      shuffle(this.widget.question.option);
      correctAnswer = this.widget.question.turkishSentence;
      for (var i = 0; i < this.widget.question.option.length; i++) {
        if (correctAnswer == this.widget.question.option[i].sentence) {
          correctIndex = i;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: this.widget.question.option.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
            child: InkWell(
              onTap: isClicked
                  ? null
                  : () async {
                      setState(() {
                        answerIndex = index;
                        isClicked = true;
                        Future.delayed(Duration(seconds: 2), () {
                          widget.incrementQuestion();
                        });
                      });
                    },
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: (answerIndex != -1 && answerIndex == index) ||
                              (isClicked && correctIndex == index)
                          ? correctIndex == index
                              ? Color(0xff3DFF39)
                              : Color(0xffFF1111)
                          : Color(0xffF5F4F4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.6),
                          spreadRadius: 0,
                          blurRadius: 1,
                          offset: Offset(0, 5),
                        ),
                      ],
                    ),
                    height: 53,
                    child: Center(
                        child:
                            Text(this.widget.question.option[index].sentence)),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List shuffle(List items) {
    var random = new Random();
    for (var i = items.length - 1; i > 0; i--) {
      var n = random.nextInt(i + 1);
      var temp = items[i];
      items[i] = items[n];
      items[n] = temp;
    }
    return items;
  }
}
