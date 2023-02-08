import 'package:flutter/material.dart' hide Colors;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/presentation/widgets/shimmer_list.dart';
import 'package:news_apps/injection.dart' as di;
import 'package:news_apps/themes/themes.dart';

import '../bloc/home_bloc.dart';
import '../widgets/article_widget.dart';

part 'home_flutter_news_section.dart';
part 'home_headline_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.injector<HomeBloc>(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: const [
                  _HomeHeadlinesSection(),
                  SizedBox(height: 16),
                  _HomeFlutterNewsSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
