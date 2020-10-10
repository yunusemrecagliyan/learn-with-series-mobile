import 'dart:math';
import 'package:learnwithseries/components/quizAnswer.dart';

import 'package:flutter/material.dart';
import 'package:learnwithseries/components/quizQuestion.dart';
import 'package:learnwithseries/components/seriesAvatar.dart';
import 'package:learnwithseries/helpers/countdown.dart';
import 'package:learnwithseries/models/episode.dart';
import 'package:learnwithseries/models/question.dart';
import 'package:learnwithseries/models/series.dart';

class QuizPage extends StatefulWidget {
  final Series serie;

  const QuizPage({Key key, this.serie}) : super(key: key);
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> with TickerProviderStateMixin {
  Episode episode;
  Series series;
  List<Question> questionList;
  bool isDispose = false;
  int questionIndex = 0;
  bool over = false;
  int _start = 50;

  @override
  void initState() {
    super.initState();
    setState(() {
      this.episode = this.widget.serie.episodes.first;
      this.series = this.widget.serie;
      this.questionList = shuffle(this.episode.questions);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey _scaffold = GlobalKey();
    return Scaffold(
        key: _scaffold,
        appBar: AppBar(
          elevation: 6.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            this.episode.name != null
                ? "${this.series.name} ${this.episode.name} Bölüm Quizi"
                : "Böyle Bir Bölüm Yok",
            style: TextStyle(color: Colors.black, fontSize: 14),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.person,
              ),
            )
          ],
        ),
        body: over
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(25),
                    child: Center(
                      child: Text(
                        "Quiz bitti.",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                  FlatButton.icon(
                      color: Color(0xFFF5F4F4),
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(
                        Icons.arrow_back,
                        size: 50,
                      ),
                      label: Text("Geri Dön"))
                ],
              )
            : Container(
                padding: EdgeInsets.symmetric(vertical: 25.0, horizontal: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            SeriesAvatar(image: series.avatarImage.url),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    this.series.name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    "${this.episode.seasonNo}. Sezon ${this.episode.chapterNo}. Bölüm",
                                    style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  Text(
                                    "Bölüm Adı: ${this.episode.name}",
                                    style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color:
                                _start >= 10 ? Color(0xffD5D4D4) : Colors.red,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                                bottomRight: Radius.circular(10)),
                            boxShadow: [
                              BoxShadow(
                                color: _start >= 10
                                    ? Colors.black.withOpacity(0.25)
                                    : Colors.red.withOpacity(0.25),
                                spreadRadius: 0,
                                blurRadius: 4,
                                offset:
                                    Offset(4, 9), // changes position of shadow
                              ),
                            ],
                          ),
                          width: 80,
                          height: 80,
                          child: Center(
                            child: CountDownTimer(
                              secondsRemaining: _start,
                              whenTimeExpires: () {
                                setState(() {
                                  over = true;
                                });
                              },
                              countDownTimerStyle:
                                  TextStyle(fontSize: 17.0, height: 1.2),
                            ),
                          ),
                        ),
                      ],
                    ),
                    QuizQuestion(
                      question: this.questionList[questionIndex],
                    ),
                    Container(
                      child: QuizAnswer(
                          question: this.questionList[questionIndex],
                          incrementQuestion: incrementQuestion),
                    ),
                  ],
                ),
              ));
  }

  void incrementQuestion() {
    if (questionIndex < questionList.length - 1)
      setState(() {
        questionIndex++;
      });
    else
      setState(() {
        over = true;
      });
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
