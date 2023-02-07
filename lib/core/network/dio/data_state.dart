import 'package:equatable/equatable.dart';

abstract class DataState<T> extends Equatable {
  final T? data;
  final String? error;

  const DataState({this.data, this.error});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);

  @override
  List<Object?> get props => [data];
}

class DataFailed<T> extends DataState<T> {
  static const networkFailure = "Oops, network failure. Please check your internet connection.";
  const DataFailed(String error) : super(error: error);

  @override
  List<Object?> get props => [error];
}
