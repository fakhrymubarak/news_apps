import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:news_apps/features/home/data/models/news_response.dart';

import '../../../../helpers/json_reader.dart';

void main() {
  group('convert json response to dart model', () {
    test('Should return NewsResponse() when read json success', () async {
      // arrange = read json
      final stringJson = readJson('feature/home/data/model/news_response.json');
      final json = jsonDecode(stringJson);

      // act
      final result = NewsResponse.fromJson(json);

      // assert
      final expectedResult =
          NewsResponse(status: 'ok', totalResults: 2, articles: [
        ArticleModel(
          source: const Source(id: "id", name: "na,e"),
          author: "BeauHD",
          title:
              "Google Releases Flutter 3.7, Teases Future of App Development Framework",
          description: "description",
          url: "https://news.slashdot.org/story/23/01/25/2055227/google-releases-flutter-37-teases-future-of-app-development-framework",
          urlToImage: "urlToImage",
          publishedAt: DateTime.now(),
          content: "content",
        ),
        ArticleModel(
          source: const Source(id: "id", name: "na,e"),
          author: "BeauHD2",
          title:
              "Google Releases Flutter 3.7, Teases Future of App Development Framework2",
          description: "description",
          url: "https://news.slashdot.org/story/23/01/25/2055227/google-releases-flutter-37-teases-future-of-app-development-framework",
          urlToImage: "urlToImage",
          publishedAt: DateTime.now(),
          content: "content",
        ),
      ]);
      expect(result, equals(expectedResult));
    });
  });
}
