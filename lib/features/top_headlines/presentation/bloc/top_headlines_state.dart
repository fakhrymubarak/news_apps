part of 'top_headlines_bloc.dart';

@immutable
abstract class TopHeadlinesState extends Equatable {
  const TopHeadlinesState();

  @override
  List<Object?> get props => [];
}

class TopHeadlineInitialState extends TopHeadlinesState {
  const TopHeadlineInitialState();
}

class TopHeadlineLoadingState extends TopHeadlinesState {
  const TopHeadlineLoadingState();
}

class TopHeadlineHasDataState extends TopHeadlinesState {
  final List<Article> articles;
  const TopHeadlineHasDataState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class TopHeadlineErrorState extends TopHeadlinesState {
  final String message;
  const TopHeadlineErrorState(this.message);

  @override
  List<Object?> get props => [message];
}