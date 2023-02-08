import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_apps/features/home/home.dart';

part 'top_headlines_event.dart';
part 'top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlinesState> {
  int _currentPage = 1;
  bool isLoading = false;
  bool isLastPage = false;

  final List<Article> _listHeadline = [];

  final NewsRepository _repository;

  TopHeadlinesBloc(this._repository) : super(const TopHeadlineInitialState()) {
    on<TopHeadlineFetch>(
      (event, emit) async {
        isLoading = true;
        emit(const TopHeadlineLoadingState());
        final result = await _repository.getTopHeadlines(page: _currentPage);

        result.fold(
          (failure) {
            isLoading = false;
            emit(TopHeadlineErrorState(failure.message));
          },
          (data) {
            isLoading = false;
            isLastPage = data.isEmpty;
            _listHeadline.addAll(data);
            emit(TopHeadlineHasDataState(_listHeadline));
          },
        );
      },
    );

    on<TopHeadlineFetchNextPage>((event, emit) {
      if (isLoading || isLastPage) return;
      _currentPage++;
      add(const TopHeadlineFetch());
    });
  }
}
