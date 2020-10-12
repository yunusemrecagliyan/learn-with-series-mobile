import 'package:flutter/material.dart';
import 'package:learnwithseries/components/seriesAvatar.dart';
import 'package:learnwithseries/models/series.dart';

class SeriesBanner extends StatelessWidget {
  final Series series;
  SeriesBanner({this.series});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 116,
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Image.network(
              this.series.backgroundImage.url,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          Container(
            padding: EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SeriesAvatar(
                  image: this.series.avatarImage.url,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Container(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 150,
                      margin: EdgeInsets.only(left: 10, top: 4),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            this.series.name,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                          this.series.episodes.first.questions == null
                              ? Text(
                                  this.series.genre,
                                  style: TextStyle(
                                      color: Color(0xffA9A9A9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              : this.series.episodes.first?.questions != null
                                  ? Text(
                                      this.series.episodes.first.seasonNo +
                                          ". Sezon " +
                                          this.series.episodes.first.chapterNo +
                                          ". Bölüm",
                                      style: TextStyle(
                                          color: Color(0xffA9A9A9),
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12),
                                    )
                                  : SizedBox(),
                          this.series.episodes.first.questions != null
                              ? Text(
                                  "Bölüm Adı: " +
                                      this.series.episodes.first.name,
                                  style: TextStyle(
                                      color: Color(0xffA9A9A9),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        "Zorluk: ${this.series.difficulty}",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
