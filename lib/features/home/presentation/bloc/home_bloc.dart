import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/article.dart';
import '../../domain/repositories/news_repository.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository _repository;

  HomeBloc(this._repository) : super(const HomeInitialState()) {
    on<HomeFetchHeadlines>((event, emit) async {
      emit(const HomeLoadingHeadlinesState());

      final result = await _repository.getTopHeadlines();

      result.fold(
        (failure) => emit(HomeErrorState(failure.message)),
        (data) => emit(HomeHeadlineHasDataState(data)),
      );
    });
  }
}
