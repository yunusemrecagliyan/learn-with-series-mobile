import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learnwithseries/models/episode.dart';
import 'package:learnwithseries/models/series.dart';
import 'package:learnwithseries/models/user.dart';
import 'package:learnwithseries/routes.dart';

import '_constants/app_contstants.dart';
import 'models/helpermodels/avatarImage.dart';
import 'models/helpermodels/backgroundImage.dart';

void main() async {
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(SeriesAdapter());
  Hive.registerAdapter(EpisodeAdapter());
  Hive.registerAdapter(AvatarImageAdapter());
  Hive.registerAdapter(BackgroundImageAdapter());

  await Hive.openBox("auth");
  await Hive.openBox("user");

  runApp(Homepage());
}

class Homepage extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey =
      new GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Learn English With Tv Series",
      initialRoute: RoutePaths.Auth,
      onGenerateRoute: Router.generateRoute,
      navigatorKey: navigatorKey,
    );
  }
}
