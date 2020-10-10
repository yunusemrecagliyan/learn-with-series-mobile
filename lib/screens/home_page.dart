import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hive/hive.dart';
import 'package:lernwithseries/_constants/app_contstants.dart';
import 'package:lernwithseries/components/seriesBanner.dart';
import 'package:lernwithseries/components/homePageMenu.dart';
import 'package:lernwithseries/components/userInfo.dart';
import 'package:lernwithseries/helpers/seriesRouteArguments.dart';
import 'package:lernwithseries/models/series.dart';
import 'package:lernwithseries/models/user.dart';
import 'package:lernwithseries/services/auth_service.dart';
import 'package:lernwithseries/services/seriesFetch.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var series = new List<Series>();
  final Widget backgroundSvg = SvgPicture.asset('assets/images/background.svg',
      semanticsLabel: 'Background');
  AuthService authService;
  User user;
  void initState() {
    super.initState();
    _getSeries();
    authService = AuthService();
    _getCurrentUser();
  }

  @override
  void didUpdateWidget(HomePage oldWidget) {
    super.didUpdateWidget(oldWidget);
    print("çalıştı");
    setState(() {
      user = Hive.box("user").get("me");
    });
  }

  _getCurrentUser() {
    authService.me().then((response) => setState(() {
          user = response;
          Hive.box("user").put("me", user);

          print("adsada" + Hive.box("user").get("me").toString());
        }));
  }

  _getSeries() {
    fetchSeries(0, 5).then((response) {
      setState(() {
        series = response;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      drawer: buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black38,
        elevation: 0,
        title: Text(
          "Anasayfa",
          style: TextStyle(color: Colors.white, fontSize: 14),
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
            UserInfo(user),
            buildHomeItems(),
            Container(
              padding: EdgeInsets.symmetric(vertical: 25, horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Senin İçin Seçtiklerimiz",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                  ),
                  ...buildSeriesBanner(series, context)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Wrap buildHomeItems() {
    return Wrap(
      spacing: 2,
      runSpacing: 2,
      children: <Widget>[
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, RoutePaths.AllSeries);
          },
          child: HomePageItem(
            backgroundImage: "assets/images/prison-break.jpg",
            icon: "assets/icons/newSeries.svg",
            title: "Yeni Bir Diziyle Öğren",
            route: "/newSeries",
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RoutePaths.SavedSeries,
                    arguments: this.user.savedSeries)
                .then((value) => _getCurrentUser());
          },
          child: HomePageItem(
            backgroundImage: "assets/images/friends.jpg",
            icon: "assets/icons/savedSeries.svg",
            title: "Kayıtlı Dizilerinle Devam Et",
            route: "/savedSeries",
          ),
        ),
        GestureDetector(
          onTap: () async {
            Navigator.pushNamed(context, RoutePaths.Series,
                arguments: await fetchRandomSeries());
          },
          child: HomePageItem(
            backgroundImage: "assets/images/breaking-bad.jpg",
            icon: "assets/icons/randomSeries.svg",
            title: "Rastgele Bir Diziyle Öğren",
            route: "/randomSeries",
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutePaths.Episode,
              arguments: SeriesRouteArguments(
                episodeId: user.lastEpisode.id.toString(),
              ),
            ).then((value) => _getCurrentUser());
          },
          child: HomePageItem(
            backgroundImage: "assets/images/how-i-met-your-mother.jpeg",
            icon: "assets/icons/lastSeries.svg",
            title: "Son Kaldığın Yerden Devam Et",
            route: "/lastSeries",
          ),
        ),
      ],
    );
  }

  buildDrawer() {
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: SafeArea(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            ListTile(
              title: Text('Anasayfa'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Profil'),
              onTap: () {
                // Update the state of the app.
                // ...
              },
            ),
            ListTile(
              title: Text('Çıkış Yap'),
              onTap: () async {
                var box = Hive.box("auth");
                await box.delete("tokens");
                print(box.get("tokens"));
                Navigator.pushNamed(context, RoutePaths.Auth);
              },
            ),
          ],
        ),
      ),
    );
  }

  buildSeriesBanner(List<Series> series, BuildContext context) {
    return List.generate(
      series.length,
      (index) => GestureDetector(
        onTap: () {
          Navigator.pushNamed(context, RoutePaths.Series,
                  arguments: series[index])
              .then((value) => setState(() {
                    user = Hive.box("user").get("me");
                  }));
        },
        child: SeriesBanner(
          series: series[index],
        ),
      ),
    );
  }
}
