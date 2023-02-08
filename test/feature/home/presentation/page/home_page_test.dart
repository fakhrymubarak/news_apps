import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/home.dart';
import 'package:news_apps/injection.dart' as di;

import '../../data/repository/news_repository_impl_test.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeEvent extends Fake implements HomeEvent {}

class FakeHomeState extends Fake implements HomeState {}

void main() {
  late MockHomeBloc mockHomeBloc;

  setUpAll(() {
    di.init();
    registerFallbackValue(FakeHomeEvent());
    registerFallbackValue(FakeHomeState());
  });

  setUp(() {
    mockHomeBloc = MockHomeBloc();
  });

  tearDown(() {
    mockHomeBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<HomeBloc>(
      create: (_) => mockHomeBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
    'should display "List Shimmer" when HomeLoadingHeadlinesState()',
    (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(makeTestableWidget(const HomePage()));
      when(() => mockHomeBloc.add(const HomeFetchHeadlines()))
          .thenAnswer((_) {});
      when(() => mockHomeBloc.state)
          .thenAnswer((_) => const HomeLoadingHeadlinesState());

      // act
      await tester.pumpWidget(makeTestableWidget(const HomePage()));

      // assert
      final articleWidget = find.byKey(Keys.listShimmer);
      expect(articleWidget, findsWidgets);
    },
  );

  testWidgets(
    'should display "List ArticleWidget" when HomeHeadlineHasDataState()',
    (WidgetTester tester) async {
      // arrange
      await tester.pumpWidget(makeTestableWidget(const HomePage()));
      when(() => mockHomeBloc.add(const HomeFetchHeadlines()))
          .thenAnswer((_) {});
      when(() => mockHomeBloc.state).thenAnswer(
          (_) => HomeHeadlineHasDataState([dummyArticle1, dummyArticle2]));

      // act
      await tester.pumpWidget(makeTestableWidget(const HomePage()));

      // assert
      final listArticle = find.byType(ListView);
      expect(listArticle, findsOneWidget);
    },
  );
}
