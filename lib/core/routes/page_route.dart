import 'package:flutter/material.dart';
import 'package:news_apps/features/home/home.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

Route onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routes.home:
      return _toPage(const HomePage());
    default:
      return _toPage(const HomePage(), settings);
  }
}

Route<dynamic> _toPage(Widget view, [RouteSettings? settings]) {
  return MaterialPageRoute(builder: (_) => view, settings: settings);
}

class Routes {
  Routes._();

  static const home = '/home';
  static const headlines = '/headlines';
}
  
  
