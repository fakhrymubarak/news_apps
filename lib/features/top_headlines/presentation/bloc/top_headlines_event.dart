part of 'top_headlines_bloc.dart';

@immutable
abstract class TopHeadlinesEvent {
  const TopHeadlinesEvent();
}

class TopHeadlineFetch extends TopHeadlinesEvent {
  const TopHeadlineFetch();
}
