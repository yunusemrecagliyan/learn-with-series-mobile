import 'package:flutter/material.dart';
import 'package:learnwithseries/models/user.dart';

class UserInfo extends StatelessWidget {
  final User user;
  UserInfo(this.user);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: user == null
          ? CircularProgressIndicator()
          : Column(
              children: [
                ClipPath(
                  clipper: UserClipper(),
                  child: Stack(
                    children: [
                      Container(
                        padding: EdgeInsets.only(top: 60),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.account_circle,
                              size: 75,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 12,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${user.firstname} ${user.lastname}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  user.username,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                          ],
                        ),
                        height: MediaQuery.of(context).size.height / 3,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment
                                .bottomCenter, // 10% of the width, so there are ten blinds.
                            colors: [
                              const Color(0xffFDB220),
                              const Color(0xffEF9103)
                            ], // red to yellow
                            tileMode: TileMode
                                .mirror, // repeats the gradient over the canvas
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Kayıtlı Dizilerim",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              user.savedSeries.length.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: 2,
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        color: Colors.white,
                      ),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Toplam Puan",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            Text(
                              user.score.toString(),
                              style:
                                  TextStyle(color: Colors.white, fontSize: 24),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  margin: EdgeInsets.symmetric(vertical: 30, horizontal: 50),
                  height: MediaQuery.of(context).size.height / 8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment
                          .bottomCenter, // 10% of the width, so there are ten blinds.
                      colors: [
                        const Color(0xffFDB220),
                        const Color(0xffEF9103)
                      ], // red to yellow
                      tileMode: TileMode
                          .mirror, // repeats the gradient over the canvas
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class UserClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 45);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(
        3 * size.width / 4, size.height, size.width, size.height - 45);

    path.lineTo(size.width, 0);

    return path;
  }

  @override
  bool shouldReclip(UserClipper oldClipper) => true;
}
