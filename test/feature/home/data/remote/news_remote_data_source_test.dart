import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/core/network/response/error_response.dart';
import 'package:news_apps/features/home/data/models/news_response.dart';
import 'package:news_apps/features/home/data/remote/news_remote_data_source.dart';
import 'package:retrofit/dio.dart';

import '../../../../helpers/test_helpers.mocks.dart';
import '../../helpers/home_test_helpers.mocks.dart';

part 'dummy_data.dart';

void main() {
  late NewsRemoteDataSource remoteDataSource;
  late MockNetworkInfo mockNetworkInfo;
  late MockNewsApiService mockApiService;

  setUp(() {
    mockNetworkInfo = MockNetworkInfo();
    mockApiService = MockNewsApiService();
    remoteDataSource = NewsRemoteDataSourceImpl(
      network: mockNetworkInfo,
      apiService: mockApiService,
    );
  });

  final tHeadlinesResponse = NewsResponse(
    status: "ok",
    totalResults: 100,
    articles: [dummyArticlesModel1, dummyArticlesModel2],
  );

  group('getListHeadlines()', () {
    group('When device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('Should return DataSuccess() when response code is 200', () async {
        // arrange - response code to 200
        final httpResponse = HttpResponse(tHeadlinesResponse, testResponseOk);

        when(mockApiService.getTopHeadlines('id', 1, 20)).thenAnswer(
          (_) async => httpResponse,
        );
        // act
        final result = await remoteDataSource.getTopHeadlines();

        // assert
        verify(mockApiService.getTopHeadlines('id', 1, 20));
        final expectedResult = DataSuccess([dummyArticlesModel1, dummyArticlesModel2]);
        expect(result, equals(expectedResult));
      });

      test('Should return DataFailed() when response code is 400', () async {
        // arrange - response code to 400
        final httpResponse = HttpResponse(tHeadlinesResponse, testResponseUnauthorized);

        when(mockApiService.getTopHeadlines('id', 1, 20)).thenAnswer(
              (_) async => httpResponse,
        );
        // act
        final result = await remoteDataSource.getTopHeadlines();

        // assert
        verify(mockApiService.getTopHeadlines('id', 1, 20));
        const expectedResult = DataFailed<List<ArticleModel>>(DataFailed.networkFailure);
        expect(result, equals(expectedResult));
      });

      test('Should return DataFailed() request send time out', () async {
        // arrange - response timeout
        when(mockApiService.getTopHeadlines('id', 1, 20)).thenAnswer(
              (_) async => throw throwDioError,
        );
        // act
        final result = await remoteDataSource.getTopHeadlines();

        // assert
        verify(mockApiService.getTopHeadlines('id', 1, 20));
        const expectedResult = DataFailed<List<ArticleModel>>("Request send timeout.");
        expect(result, equals(expectedResult));
      });
    });

    group('When device is offline', () {
      test('Should return DataFailed() when app has no internet', () async {
        // arrange - apps offline
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => false);

        // act
        final result = await remoteDataSource.getTopHeadlines();

        // assert
        verifyNever(mockApiService.getTopHeadlines('id', 1, 20));
        const expectedResult = DataFailed<List<ArticleModel>>(DataFailed.networkFailure);
        expect(result, equals(expectedResult));
      });
    });
  });
}
