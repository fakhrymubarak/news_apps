import 'package:dartz/dartz.dart';
import 'package:news_apps/core/core.dart';
import 'package:news_apps/features/home/data/remote/news_remote_data_source.dart';
import 'package:news_apps/features/home/domain/repositories/news_repository.dart';

import '../../domain/entities/article.dart';

class NewsRepositoryImpl extends NewsRepository {
  final NewsRemoteDataSource remoteDataSource;

  NewsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Article>>> getTopHeadlines({int page = 1}) async {
    final result = await remoteDataSource.getTopHeadlines(page: page);
    if (result is DataSuccess) {
      return Right(result.data!.map((model) => model.toEntity()).toList());
    } else {
      return Left(ServerFailure(result.error!));
    }
  }
}
