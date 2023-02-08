import 'package:dartz/dartz.dart';

import '../entities/article.dart';
import 'package:news_apps/core/core.dart';

abstract class NewsRepository {
  Future<Either<Failure, List<Article>>> getTopHeadlines({int page = 1});
}