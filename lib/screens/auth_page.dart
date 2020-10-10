import 'package:flutter/material.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment
              .bottomCenter, // 10% of the width, so there are ten blinds.
          colors: [
            const Color(0xffFDB220),
            const Color(0xffEF9103)
          ], // red to yellow
          tileMode: TileMode.mirror, // repeats the gradient over the canvas
        )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Dizilerle İngilizce Öğren",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, RoutePaths.Login);
              },
              child: Container(
                height: 58,
                width: MediaQuery.of(context).size.width - 40,
                margin: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      spreadRadius: 0,
                      blurRadius: 4,
                      offset: Offset(0, 4), // changes position of shadow
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    "Giriş Yap",
                    style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () async {
                Navigator.pushNamed(context, RoutePaths.Register);
              },
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 58,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.white, width: 2),
                  color: Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "Kayıt Ol",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 26,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
