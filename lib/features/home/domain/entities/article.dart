
import 'package:equatable/equatable.dart';

class Article extends Equatable{
  const Article({
    required this.source,
    required this.author,
    required this.title,
    required this.description,
    required this.url,
    required this.urlToImage,
    required this.publishedAt,
  });

  final String source;
  final String author;
  final String title;
  final String description;
  final String url;
  final String urlToImage;
  final DateTime publishedAt;

  @override
  List<Object?> get props => [source, author, title];
}