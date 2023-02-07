part of 'news_remote_data_source_test.dart';

// dummy helpers
final tArticles1 = ArticleModel(
  source: const Source(id: "id", name: "na,e"),
  author: "author1",
  title: "title1",
  description: "description",
  url: "url",
  urlToImage: "urlToImage",
  publishedAt: DateTime.now(),
  content: "content",
);

final tArticles2 = ArticleModel(
  source: const Source(id: "id", name: "na,e"),
  author: "author2",
  title: "title2",
  description: "description",
  url: "url",
  urlToImage: "urlToImage",
  publishedAt: DateTime.now(),
  content: "content",
);


final testResponseOk = Response(
  requestOptions: RequestOptions(path: "/"),
  statusCode: HttpStatus.ok,
);

final testResponseUnauthorized = Response(
  requestOptions: RequestOptions(path: "/"),
  statusCode: HttpStatus.unauthorized,
);

final throwDioError = DioError(
  requestOptions: RequestOptions(path: "/"),
  type: DioErrorType.sendTimeout
);

final testResponseError = ErrorResponse(
    status : "status",
    code : "code",
    message : "message",
);
