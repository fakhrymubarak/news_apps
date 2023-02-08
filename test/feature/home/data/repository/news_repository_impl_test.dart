import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/data/repositories/news_repository_impl.dart';
import 'package:news_apps/features/home/domain/entities/article.dart';

import '../../helpers/home_test_helpers.mocks.dart';
import '../remote/news_remote_data_source_test.dart';

part 'dummy_data.dart';

void main() {
  late NewsRepositoryImpl repository;
  late MockNewsRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockNewsRemoteDataSource();
    repository = NewsRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
    );
  });

  final tArticles = [dummyArticle1, dummyArticles2];

  group('getTopHeadlines()', () {
    test(
        'Should return [List<Article>] when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopHeadlines()).thenAnswer(
          (_) async => DataSuccess([dummyArticlesModel1, dummyArticlesModel2]));

      // act
      final result = await repository.getTopHeadlines();

      // assert
      verify(mockRemoteDataSource.getTopHeadlines());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tArticles);
      expect(resultList, resultList);
    });

    test(
        'Should return [ServerFailure()] when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getTopHeadlines())
          .thenAnswer((_) async => const DataFailed(DataFailed.networkFailure));
      // act
      final result = await repository.getTopHeadlines();
      // assert
      verify(mockRemoteDataSource.getTopHeadlines());
      const expectedResult = Left(ServerFailure(DataFailed.networkFailure));
      expect(result, equals(expectedResult));
    });
  });
}
