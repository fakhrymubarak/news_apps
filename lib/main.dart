import 'package:flutter/material.dart';

import 'core/core.dart';
import 'features/home/home.dart';
import 'injection.dart' as di;
import 'themes/themes.dart';

void main() async {
  di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const HomePage(),
      navigatorObservers: [routeObserver],
      theme: getAppTheme(context),
      onGenerateRoute: (settings) => onGenerateRoute(settings),
      debugShowCheckedModeBanner: false,
    );
  }
}
