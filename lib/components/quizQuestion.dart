import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/models/question.dart';

class QuizQuestion extends StatefulWidget {
  final Question question;

  QuizQuestion({Key key, this.question}) : super(key: key);

  @override
  _QuizQuestionState createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  final Widget backgroundSvg = SvgPicture.asset('assets/icons/quizQuestion.svg',
      semanticsLabel: 'Background');
  AudioPlayer audioPlayer = AudioPlayer();

  bool isShow = false;
  @override
  void initState() {
    play();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 25),
      child: Stack(
        children: <Widget>[
          Container(child: backgroundSvg),
          Container(
            padding: EdgeInsets.all(40),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () async => play(),
                  icon: Icon(
                    Icons.play_circle_filled,
                    size: 55,
                    color: Colors.grey[700],
                  ),
                ),
                !isShow
                    ? InkWell(
                        child: Text("Cümleyi Göster"),
                        onTap: () {
                          setState(() {
                            isShow = !isShow;
                          });
                        },
                      )
                    : Expanded(
                        child: Text(this.widget.question.englishSentence),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  play() async {
    await audioPlayer.stop();
    await audioPlayer.setUrl(baseUrl +
        this
            .widget
            .question
            .sound
            .url); // prepare the player with this audio but do not start playing
    await audioPlayer.setReleaseMode(
        ReleaseMode.STOP); // set release mode so that it never releases

    // on button click
    await audioPlayer.resume(); // quickly play
  }
}
