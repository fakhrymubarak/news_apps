part of 'top_headlines_bloc.dart';

@immutable
abstract class TopHeadlineState extends Equatable {
  const TopHeadlineState();

  @override
  List<Object?> get props => [];
}

class TopHeadlineInitialState extends TopHeadlineState {
  const TopHeadlineInitialState();
}

class TopHeadlineLoadingState extends TopHeadlineState {
  const TopHeadlineLoadingState();
}

class TopHeadlineHasDataState extends TopHeadlineState {
  final List<Article> articles;
  const TopHeadlineHasDataState(this.articles);

  @override
  List<Object?> get props => [articles];
}

class TopHeadlineErrorState extends TopHeadlineState {
  final String message;
  const TopHeadlineErrorState(this.message);

  @override
  List<Object?> get props => [message];
}