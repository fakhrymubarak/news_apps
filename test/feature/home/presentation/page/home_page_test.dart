import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/home.dart';
import 'package:news_apps/injection.dart' as di;
import 'package:webview_flutter/webview_flutter.dart';

import '../../data/repository/news_repository_impl_test.dart';
import 'fake_web_view_platform.dart';

class MockHomeBloc extends MockBloc<HomeEvent, HomeState> implements HomeBloc {}

class FakeHomeEvent extends Fake implements HomeEvent {}

class FakeHomeState extends Fake implements HomeState {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  late MockHomeBloc mockHomeBloc;
  final mockObserver = MockNavigatorObserver();

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
        navigatorObservers: [mockObserver],
        onGenerateRoute: onGenerateRoute,
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
      final listArticle = find.byType(ListView);
      expect(listArticle, findsOneWidget);

      // assert
      await tester.pumpWidget(makeTestableWidget(ArticleWidget(article: dummyArticle1)));
      final cardWidget = find.byKey(Keys.articleWidget);
      expect(cardWidget, findsOneWidget);
    },
  );

  testWidgets(
    'onTap "ArticleWidget" should navigateTo NewsDetailPage()',
    (WidgetTester tester) async {
      // arrange
      WebViewPlatform.instance = FakeWebViewPlatform();

      await tester.pumpWidget(makeTestableWidget(const HomePage()));
      when(() => mockHomeBloc.add(const HomeFetchHeadlines()))
          .thenAnswer((_) {});
      when(() => mockHomeBloc.state).thenAnswer(
              (_) => HomeHeadlineHasDataState([dummyArticle1, dummyArticle2]));
      await tester.pumpWidget(makeTestableWidget(ArticleWidget(article: dummyArticle1)));

      // act
      final tappableCard = find.byType(InkWell);
      expect(tappableCard, findsOneWidget);
      await tester.tap(tappableCard);
      await tester.pumpAndSettle();

      // assert
      final webView = find.byType(WebViewWidget);
      expect(webView, findsOneWidget);
    },
  );
}
