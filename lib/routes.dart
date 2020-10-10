import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:learnwithseries/helpers/seriesRouteArguments.dart';
import 'package:learnwithseries/models/series.dart';
import 'package:learnwithseries/screens/all_series_page.dart';
import 'package:learnwithseries/screens/auth_page.dart';
import 'package:learnwithseries/screens/login_page.dart';
import 'package:learnwithseries/screens/episode_page.dart';
import 'package:learnwithseries/screens/home_page.dart';
import 'package:learnwithseries/screens/quiz_page.dart';
import 'package:learnwithseries/screens/register_page.dart';
import 'package:learnwithseries/screens/saved_series_page.dart';
import 'package:learnwithseries/screens/series_page.dart';

import 'package:learnwithseries/_constants/app_contstants.dart';

class MyRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => HomePage());
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginPage());
      case RoutePaths.Register:
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case RoutePaths.Auth:
        var hasTokens = Hive.box("auth").get("tokens");
        var page;
        if (hasTokens != null) {
          page = MaterialPageRoute(builder: (_) => HomePage());
        } else {
          page = MaterialPageRoute(builder: (_) => Auth());
        }
        return page;
      case RoutePaths.AllSeries:
        return MaterialPageRoute(builder: (_) => AllSeries());
      case RoutePaths.Series:
        var series = settings.arguments as Series;
        return MaterialPageRoute(builder: (_) => SeriesPage(series: series));
      case RoutePaths.Episode:
        var arguments = settings.arguments as SeriesRouteArguments;

        return MaterialPageRoute(
            builder: (_) => EpisodePage(arguments: arguments));
      case RoutePaths.Quiz:
        var serie = settings.arguments as Series;
        return MaterialPageRoute(builder: (_) => QuizPage(serie: serie));
      case RoutePaths.SavedSeries:
        var series = settings.arguments as List<Series>;
        return MaterialPageRoute(builder: (_) => SavedSeries(series: series));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
