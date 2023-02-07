import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/news_response.dart';

part 'news_api_service.g.dart';

@RestApi()
abstract class NewsApiService {
  factory NewsApiService(Dio dio) = _NewsApiService;

  @GET('/top-headlines?')
  Future<HttpResponse<NewsResponse>> getTopHeadlines(
    @Query("country") String country,
    @Query("page") int page,
    @Query("pageSize") int pageSize,
  );
}
