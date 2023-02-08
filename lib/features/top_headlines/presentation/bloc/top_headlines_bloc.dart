import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:news_apps/features/home/home.dart';

part 'top_headlines_event.dart';
part 'top_headlines_state.dart';

class TopHeadlinesBloc extends Bloc<TopHeadlinesEvent, TopHeadlineState> {
  final NewsRepository _repository;

  TopHeadlinesBloc(this._repository) : super(const TopHeadlineInitialState()) {
    on<TopHeadlineFetch>((event, emit) async {
      emit(const TopHeadlineLoadingState());

      final result = await _repository.getTopHeadlines();

      result.fold(
        (failure) => emit(TopHeadlineErrorState(failure.message)),
        (data) => emit(TopHeadlineHasDataState(data)),
      );
    });
  }
}
