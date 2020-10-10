import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/components/seriesBanner.dart';
import 'package:lernwithseries/models/series.dart';
import 'package:lernwithseries/services/seriesFetch.dart';

class AllSeries extends StatefulWidget {
  @override
  _AllSeriesState createState() => _AllSeriesState();
}

class _AllSeriesState extends State<AllSeries> {
  var series = new List<Series>();
  void initState() {
    super.initState();
    _getSeries();
  }

  _getSeries() {
    fetchSeries().then((response) {
      setState(() {
        series = response;
      });
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
          "Diziler",
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
