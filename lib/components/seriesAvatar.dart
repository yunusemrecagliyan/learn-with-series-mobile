import 'package:flutter/material.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';

class SeriesAvatar extends StatelessWidget {
  final String image;
  final String episode;
  final String season;

  const SeriesAvatar({Key key, this.image, this.episode, this.season})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.centerLeft, children: <Widget>[
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.network(
          baseUrl + this.image,
          fit: BoxFit.cover,
          height: 90,
          width: 90,
        ),
      ),
      ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Container(
            padding: EdgeInsets.all(5),
            width: 90,
            height: 90,
            color: Colors.black.withOpacity(0.2),
            child: this.episode != null && this.season != null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        this.season + ". Sezon",
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(this.episode + ". Bölüm",
                          style: TextStyle(color: Colors.white))
                    ],
                  )
                : SizedBox()),
      )
    ]);
  }
}
