import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_apps/features/home/home.dart';
import 'package:news_apps/features/top_headlines/top_headlines.dart';

import 'core/core.dart';

final injector = GetIt.instance;

void init() {
  injector.registerSingleton<Dio>(
      DioFactory(baseUrl: "https://newsapi.org/v2").create());
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  _newsInjector();
}

void _newsInjector() {
  injector.registerFactory(() => HomeBloc(injector()));
  injector.registerFactory(() => TopHeadlinesBloc(injector()));

  injector.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(remoteDataSource: injector()),
  );
  injector.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(apiService: injector(), network: injector()),
  );

  injector.registerLazySingleton(() => NewsApiService(injector()));
}
