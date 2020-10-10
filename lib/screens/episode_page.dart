import 'package:flutter/material.dart';
import 'package:learnwithseries/_constants/app_contstants.dart';
import 'package:learnwithseries/components/seriesBanner.dart';
import 'package:learnwithseries/helpers/seriesRouteArguments.dart';
import 'package:learnwithseries/models/episode.dart';
import 'package:learnwithseries/models/series.dart';
import 'package:learnwithseries/models/user.dart';
import 'package:learnwithseries/services/auth_service.dart';
import 'package:learnwithseries/services/episodeFetch.dart';
import 'package:learnwithseries/services/seriesFetch.dart';

class EpisodePage extends StatefulWidget {
  final SeriesRouteArguments arguments;
  EpisodePage({this.arguments});
  @override
  _EpisodePageState createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  var episode = new Episode();
  var series = new Series();
  User me;

  bool loading = true;
  void initState() {
    super.initState();
    if (this.widget.arguments.series != null) {
      series = Series.fromJson(this.widget.arguments.series?.toJson());
      series.episodes.clear();
    } else {
      findSerie(episodeId: this.widget.arguments.episodeId)
          .then((value) => series = value);
    }

    _getEpisode();
  }

  _getEpisode() {
    fetchEpisode(this.widget.arguments.episodeId).then((response) {
      setState(() {
        episode = response;
        series.episodes.add(episode);
      });
    }).whenComplete(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 6.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          this.episode.name != null
              ? this.series.name + " - " + this.episode.name
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
      body: Container(
        padding: EdgeInsets.all(11),
        child: loading
            ? CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        child: SeriesBanner(
                          series: series,
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            "Bölümde Geçen Kelimeler",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: <Widget>[
                                Text(
                                  "Cümleler",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600),
                                ),
                                ...List.generate(
                                    episode.questions.length,
                                    (index) => Container(
                                          child: Text(episode.questions[index]
                                              .englishSentence),
                                        ))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10),
                          topRight: Radius.circular(10),
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 4,
                          offset: Offset(2, 5), // changes position of shadow
                        ),
                      ],
                    ),
                    child: episode.questions.length == 0
                        ? Text("Sorular henüz eklenmedi.")
                        : FlatButton(
                            onPressed: () {
                              AuthService auth = new AuthService();
                              Map<String, int> updateFields;
                              updateFields = {"lastEpisode": episode.id};
                              auth.update(updateFields);
                              Navigator.pushNamed(context, RoutePaths.Quiz,
                                  arguments: this.series);
                            },
                            child: Text("Teste Başla"),
                            color: Color(0xffF5F4F4),
                            padding: EdgeInsets.all(13),
                            highlightColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                          ),
                  )
                ],
              ),
      ),
    );
  }
}
