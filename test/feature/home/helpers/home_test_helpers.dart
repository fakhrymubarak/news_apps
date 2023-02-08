import 'package:mockito/annotations.dart';
import 'package:news_apps/features/home/data/remote/news_api_service.dart';
import 'package:news_apps/features/home/data/remote/news_remote_data_source.dart';
import 'package:news_apps/features/home/domain/repositories/news_repository.dart';

@GenerateMocks([
  NewsRepository,
  NewsRemoteDataSource,
  NewsApiService,
], customMocks: [])
void main() {}
