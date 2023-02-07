import 'package:dio/dio.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/data/remote/news_api_service.dart';

import '../models/news_response.dart';

abstract class NewsRemoteDataSource {
  Future<DataState<List<ArticleModel>>> getTopHeadlines();
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final NewsApiService apiService;
  final NetworkInfo network;

  NewsRemoteDataSourceImpl({
    required this.network,
    required this.apiService,
  });

  @override
  Future<DataState<List<ArticleModel>>> getTopHeadlines() async {
    if (!await network.isConnected) {
      return const DataFailed(DataFailed.networkFailure);
    }

    try {
      final httpResponse = await apiService.getTopHeadlines('id', 1, 20);

      final data = httpResponse.data.articles;
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(data);
      } else {
        return const DataFailed(DataFailed.networkFailure);
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      return DataFailed(errorMessage);
    }
  }
}