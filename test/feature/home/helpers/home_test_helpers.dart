import 'package:mockito/annotations.dart';
import 'package:news_apps/features/home/data/remote/news_api_service.dart';
import 'package:news_apps/features/home/data/remote/news_remote_data_source.dart';

@GenerateMocks([
  NewsRemoteDataSource,
  NewsApiService,
], customMocks: [])
void main() {}
