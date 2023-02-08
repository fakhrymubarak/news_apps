import 'package:dio/dio.dart';
import 'package:news_apps/core/core.dart';

import '../models/news_response.dart';
import 'news_api_service.dart';

abstract class NewsRemoteDataSource {
  Future<DataState<List<ArticleModel>>> getTopHeadlines({
    String country = 'id',
    int page = 1,
    int pageSize = 10,
  });
}

class NewsRemoteDataSourceImpl extends NewsRemoteDataSource {
  final NewsApiService apiService;
  final NetworkInfo network;

  NewsRemoteDataSourceImpl({
    required this.network,
    required this.apiService,
  });

  @override
  Future<DataState<List<ArticleModel>>> getTopHeadlines({
    String country = 'id',
    int page = 1,
    int pageSize = 10,
  }) async {
    if (!await network.isConnected) {
      return const DataFailed(DataFailed.networkFailure);
    }

    try {
      final httpResponse = await apiService.getTopHeadlines(country, page, pageSize);

      final data = httpResponse.data.articles;
      if (httpResponse.response.statusCode == 200) {
        return DataSuccess(data);
      } else {
        return const DataFailed(DataFailed.networkFailure);
      }
    } on DioError catch (e) {
      final errorMessage = DioException.fromDioError(e).toString();
      return DataFailed(errorMessage);
    } catch (e, stackTrace) {
      logError(e.toString(), stackTrace);
      return DataFailed(e.toString());
    }
  }
}
