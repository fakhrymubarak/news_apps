part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitialState extends HomeState {
  const HomeInitialState();
}

class HomeLoadingHeadlinesState extends HomeState {
  const HomeLoadingHeadlinesState();
}

class HomeHeadlineHasDataState extends HomeState {
  final List<Article> articles;
  const HomeHeadlineHasDataState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class HomeErrorState extends HomeState {
  final String message;
  const HomeErrorState(this.message);

  @override
  List<Object?> get props => [message];
}