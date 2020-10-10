import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/components/seriesBanner.dart';
import 'package:lernwithseries/models/episode.dart';
import 'package:lernwithseries/models/series.dart';
import 'package:lernwithseries/screens/home_page.dart';

class SavedSeries extends StatefulWidget {
  final List<Series> series;
  SavedSeries({this.series});
  @override
  _SavedSeriesState createState() => _SavedSeriesState();
}

class _SavedSeriesState extends State<SavedSeries> {
  List<Series> series;

  void initState() {
    super.initState();
    series = this.widget.series;
    series.forEach((element) {
      element.episodes = [];
      element.episodes.add(Episode());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 6.0,
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          "Kayıtlı Dizilerin",
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Diziler",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  ...buildSeriesBanner(series, context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

buildSeriesBanner(List<Series> series, BuildContext context) {
  return List.generate(
      series.length,
      (index) => GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, RoutePaths.Series,
                  arguments: series[index]);
            },
            child: SeriesBanner(
              series: series[index],
            ),
          ));
}
