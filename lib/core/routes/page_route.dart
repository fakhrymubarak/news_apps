import 'package:flutter/material.dart';
import 'package:news_apps/features/features.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _toPage(const HomePage());
    case Routes.newsDetails:
      final url = settings.arguments as String;
      return _toPage(NewsDetailPage(webUrl: url));
    case Routes.headlines:
      return _toPage(const TopHeadlinesPage());
    default:
      return _toPage(const HomePage(), settings);
  }
}

Route<dynamic> _toPage(Widget view, [RouteSettings? settings]) {
  return PageRouteBuilder(
    pageBuilder: (_, __, ___) => view,
    transitionsBuilder: (_, animation, __, child) =>
        _transitionLeftToRight(animation, child),
    settings: settings,
  );
}

class Routes {
  Routes._();

  static const home = '/home';
  static const headlines = '/headlines';
  static const newsDetails = '/news-details';
}

SlideTransition _transitionLeftToRight(
    Animation<double> animation, Widget child) {
  const begin = Offset(1.0, 0.0);
  const end = Offset.zero;
  const curve = Curves.ease;

  var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

  return SlideTransition(
    position: animation.drive(tween),
    child: child,
  );
}
