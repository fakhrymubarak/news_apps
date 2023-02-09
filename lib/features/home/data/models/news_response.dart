import 'package:equatable/equatable.dart';
import 'package:news_apps/features/home/domain/entities/article.dart';

class NewsResponse extends Equatable {
  const NewsResponse({
    required this.status,
    required this.totalResults,
    required this.articles,
  });

  final String status;
  final int totalResults;
  final List<ArticleModel> articles;

  factory NewsResponse.fromJson(Map<String, dynamic> json) => NewsResponse(
        status: json["status"],
        totalResults: json["totalResults"],
        articles: List<ArticleModel>.from(
            json["articles"].map((x) => ArticleModel.fromJson(x))),
      );

  @override
  List<Object?> get props => [status, totalResults, articles];
}

class ArticleModel extends Equatable {
  const ArticleModel({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
    required this.content,
  });

  final Source source;
  final String? author;
  final String title;
  final String description;
  final String url;
  final String? urlToImage;
  final DateTime publishedAt;
  final String? content;

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        source: Source.fromJson(json["source"]),
        author: json["author"],
        title: json["title"],
        description: json["description"],
        url: json["url"],
        urlToImage: json["urlToImage"],
        publishedAt: DateTime.parse(json["publishedAt"]),
        content: json["content"],
      );

  Article toEntity() => Article(
      sourceco: source.name,
      author: author ?? '-',
      title: title,
      description: description,
      url: url,
      urlToImage: urlToImage ?? "",
      publishedAt: publishedAt.toString().substring(0, 10));

  @override
  List<Object?> get props => [author, title];
}

class Source {
  const Source({
    required this.id,
    required this.name,
  });

  final String? id;
  final String name;

  factory Source.fromJson(Map<String, dynamic> json) => Source(
        id: json["id"],
        name: json["name"],
      );
}
