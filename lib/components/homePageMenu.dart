import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePageItem extends StatelessWidget {
  final String title;
  final String backgroundImage;
  final String route;
  final String icon;
  HomePageItem({this.title, this.backgroundImage, this.icon, this.route});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - 1,
      height: 200,
      child: Stack(
        children: <Widget>[
          Image.asset(
            this.backgroundImage,
            fit: BoxFit.cover,
            height: 400,
          ),
          Container(
            color: Colors.black.withOpacity(0.5),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Text(
                    this.title,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 25),
                  child:
                      SvgPicture.asset(this.icon, semanticsLabel: this.title),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
