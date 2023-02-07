import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:news_apps/features/home/data/remote/news_api_service.dart';
import 'package:news_apps/features/home/data/remote/news_remote_data_source.dart';

import 'core/core.dart';

final injector = GetIt.instance;

void init() {
  injector.registerSingleton<Dio>(
      DioFactory(baseUrl: "https://newsapi.org/v2").create());
  injector.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());

  _newsInjector();
}

void _newsInjector() {

  injector.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(apiService: injector(), network: injector()),
  );

  injector.registerLazySingleton(() => NewsApiService(injector()));
}
