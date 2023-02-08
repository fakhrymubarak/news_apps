import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/features.dart';
import 'package:news_apps/injection.dart' as di;

import '../../../home/data/repository/news_repository_impl_test.dart';


class MockTopHeadlinesBloc extends MockBloc<TopHeadlinesEvent, TopHeadlinesState> implements TopHeadlinesBloc {}

class FakeTopHeadlinesEvent extends Fake implements TopHeadlinesEvent {}

class FakeTopHeadlinesState extends Fake implements TopHeadlinesState {}

void main() {
  late MockTopHeadlinesBloc mockTopHeadlinesBloc;

  setUpAll(() {
    di.init();
    registerFallbackValue(FakeTopHeadlinesEvent());
    registerFallbackValue(FakeTopHeadlinesState());
  });

  setUp(() {
    mockTopHeadlinesBloc = MockTopHeadlinesBloc();
  });

  tearDown(() {
    mockTopHeadlinesBloc.close();
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TopHeadlinesBloc>(
      create: (_) => mockTopHeadlinesBloc,
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
      when(() => mockTopHeadlinesBloc.add(const TopHeadlineFetch()))
          .thenAnswer((_) {});
      when(() => mockTopHeadlinesBloc.state)
          .thenAnswer((_) => const TopHeadlineLoadingState());

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
      when(() => mockTopHeadlinesBloc.add(const TopHeadlineFetch()))
          .thenAnswer((_) {});
      when(() => mockTopHeadlinesBloc.state).thenAnswer(
          (_) => TopHeadlineHasDataState([dummyArticle1, dummyArticle2]));

      // act
      await tester.pumpWidget(makeTestableWidget(const HomePage()));

      // assert
      final listArticle = find.byType(ListView);
      expect(listArticle, findsOneWidget);
    },
  );
}
