part of 'news_remote_data_source_test.dart';

// dummy helpers
final dummyArticlesModel1 = ArticleModel(
  source: const Source(id: "id", name: "na,e"),
  author: "author1",
  title: "title1",
  description: "description",
  url: "https://news.slashdot.org/story/23/01/25/2055227/google-releases-flutter-37-teases-future-of-app-development-framework",
  urlToImage: "urlToImage",
  publishedAt: DateTime.now(),
  content: "content",
);

final dummyArticlesModel2 = ArticleModel(
  source: const Source(id: "id", name: "na,e"),
  author: "author2",
  title: "title2",
  description: "description",
  url: "https://news.slashdot.org/story/23/01/25/2055227/google-releases-flutter-37-teases-future-of-app-development-framework",
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
