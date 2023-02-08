import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/domain/entities/article.dart';
import 'package:news_apps/features/top_headlines/top_headlines.dart';

import '../../../home/data/repository/news_repository_impl_test.dart';
import '../../../home/helpers/home_test_helpers.mocks.dart';

void main() {
  late TopHeadlinesBloc bloc;
  late MockNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockNewsRepository();
    bloc = TopHeadlinesBloc(mockRepository);
  });

  final List<Article> tListArticle = [dummyArticle1, dummyArticle2];

  group('Fetch Headline News', () {
    blocTest<TopHeadlinesBloc, TopHeadlinesState>(
      'Should emit [Loading, Error] when get headline news is failed',
      build: () {
        when(mockRepository.getTopHeadlines()).thenAnswer(
            (_) async => const Left(ServerFailure(DataFailed.networkFailure)));
        return bloc;
      },
      act: (bloc) => bloc.add(const TopHeadlineFetch()),
      expect: () => <TopHeadlinesState>[
        const TopHeadlineLoadingState(),
        const TopHeadlineErrorState(DataFailed.networkFailure)
      ],
    );

    blocTest<TopHeadlinesBloc, TopHeadlinesState>(
      'Should emit [Loading, Has Data] when get headline news is successful',
      build: () {
        when(mockRepository.getTopHeadlines())
            .thenAnswer((_) async => Right(tListArticle));
        return bloc;
      },
      act: (bloc) => bloc.add(const TopHeadlineFetch()),
      expect: () => <TopHeadlinesState>[
        const TopHeadlineLoadingState(),
        TopHeadlineHasDataState(tListArticle),
      ],
    );
  });

  group('Fetch Next Page of Headline News', () {
    blocTest<TopHeadlinesBloc, TopHeadlinesState>(
      'Should emit [Loading, Error] when get headline news is failed',
      build: () {
        when(mockRepository.getTopHeadlines(page: 2)).thenAnswer(
            (_) async => const Left(ServerFailure(DataFailed.networkFailure)));
        return bloc;
      },
      act: (bloc) => bloc.add(const TopHeadlineFetchNextPage()),
      expect: () => <TopHeadlinesState>[
        const TopHeadlineLoadingState(),
        const TopHeadlineErrorState(DataFailed.networkFailure)
      ],
    );

    blocTest<TopHeadlinesBloc, TopHeadlinesState>(
      'Should emit [Loading, Has Data] when get headline news is successful',
      build: () {
        when(mockRepository.getTopHeadlines(page: 2))
            .thenAnswer((_) async => Right(tListArticle));
        return bloc;
      },
      act: (bloc) => bloc.add(const TopHeadlineFetchNextPage()),
      expect: () => <TopHeadlinesState>[
        const TopHeadlineLoadingState(),
        TopHeadlineHasDataState(tListArticle),
      ],
    );
  });
}
