import 'package:mockito/annotations.dart';
import 'package:news_apps/features/home/home.dart';

@GenerateMocks([
  NewsRepository,
  NewsRemoteDataSource,
  NewsApiService,
], customMocks: [])
void main() {}
