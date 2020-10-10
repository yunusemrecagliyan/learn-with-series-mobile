import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'package:learnwithseries/_constants/app_contstants.dart';
import 'package:learnwithseries/components/seriesAvatar.dart';
import 'package:learnwithseries/components/seriesBanner.dart';
import 'package:learnwithseries/helpers/seriesRouteArguments.dart';
import 'package:learnwithseries/models/series.dart';
import 'package:learnwithseries/models/user.dart';
import 'package:learnwithseries/services/auth_service.dart';
import 'package:learnwithseries/services/seriesFetch.dart';

class SeriesPage extends StatefulWidget {
  final Series series;
  SeriesPage({this.series});
  @override
  _SeriesPageState createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  String dropdownValue;
  Series series;
  User me;
  bool isFavorite;
  @override
  void initState() {
    me = Hive.box("user").get("me");

    super.initState();
    series = this.widget.series;
    print(this.widget.series.episodes.first.id);

    if (this.widget.series.episodes.first.id == null) {
      findSerie(id: this.widget.series.id).then((value) => {
            setState(() {
              series = value;
            })
          });
    }
    isFavorite = me.savedSeries?.any((ss) {
      print(series.id);
      return ss.id == series.id;
    });
  }

  @override
  SeriesPage get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 6.0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            series.name,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(bottom: 20),
                child: SeriesBanner(
                  series: series,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: FlatButton.icon(
                    onPressed: () {
                      AuthService auth = new AuthService();
                      Map<String, List<int>> updateFields;
                      if (!isFavorite) {
                        updateFields = {
                          "savedSeries": [
                            ...me.savedSeries.map((ss) => ss.id),
                            series.id
                          ]
                        };
                      } else {
                        updateFields = {
                          "savedSeries": [
                            ...me.savedSeries
                                .where((ss) => ss.id != series.id)
                                .map((e) => e.id),
                          ]
                        };
                      }
                      setState(() {
                        isFavorite = !isFavorite;
                      });

                      auth.update(updateFields);
                    },
                    icon: isFavorite == true
                        ? Icon(Icons.remove_from_queue)
                        : Icon(Icons.add_to_queue),
                    label: Text(
                      isFavorite == true
                          ? "Diziyi Favorilerimden Çıkar"
                          : "Diziyi Favorilerime Ekle",
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              Text(
                "Hakkında",
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
              ),
              Text(series.description,
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.w400)),
              Container(
                margin: EdgeInsets.only(top: 8, bottom: 8),
                child: Text(
                  "Bölümler",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Color(0xffF5F4F4),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 5,
                      offset: Offset(1, 5), // changes position of shadow
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    isExpanded: true,
                    value: dropdownValue,
                    iconSize: 24,
                    hint: Text("Sezon Seçiniz.."),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: List.generate(this.series.seasonCount,
                            (index) => "${index + 1}. Sezon")
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Wrap(
                    spacing: 14,
                    runSpacing: 8,
                    children: <Widget>[
                      ...List.generate(
                          series.episodes.length,
                          (index) => GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    RoutePaths.Episode,
                                    arguments: SeriesRouteArguments(
                                        episodeId: series.episodes[index].id
                                            .toString(),
                                        series: series),
                                  );
                                },
                                child: SeriesAvatar(
                                  image: series.avatarImage.url,
                                  episode: series.episodes[index].chapterNo,
                                  season: series.episodes[index].seasonNo,
                                ),
                              ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
