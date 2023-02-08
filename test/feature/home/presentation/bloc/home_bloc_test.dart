import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/domain/entities/article.dart';
import 'package:news_apps/features/home/presentation/bloc/home_bloc.dart';

import '../../data/repository/news_repository_impl_test.dart';
import '../../helpers/home_test_helpers.mocks.dart';

void main() {
  late HomeBloc bloc;
  late MockNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockNewsRepository();
    bloc = HomeBloc(mockRepository);
  });

  final List<Article> tListArticle = [dummyArticle1, dummyArticle2];

  group('Fetch Headline News', () {
    blocTest<HomeBloc, HomeState>(
      'Should emit [Loading, Error] when get headline news is failed',
      build: () {
        when(mockRepository.getTopHeadlines()).thenAnswer(
            (_) async => const Left(ServerFailure(DataFailed.networkFailure)));
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeFetchHeadlines()),
      expect: () => <HomeState>[
        const HomeLoadingHeadlinesState(),
        const HomeErrorState(DataFailed.networkFailure)
      ],
    );
    blocTest<HomeBloc, HomeState>(
      'Should emit [Loading, Has Data] when get headline news is successful',
      build: () {
        when(mockRepository.getTopHeadlines())
            .thenAnswer((_) async => Right(tListArticle));
        return bloc;
      },
      act: (bloc) => bloc.add(const HomeFetchHeadlines()),
      expect: () => <HomeState>[
        const HomeLoadingHeadlinesState(),
        HomeHeadlineHasDataState(tListArticle),
      ],
    );
  });
}
