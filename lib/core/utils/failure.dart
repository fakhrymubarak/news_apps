import 'package:equatable/equatable.dart';
import 'package:news_apps/themes/resources/resource.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(String message) : super(message);
}

class ConnectionFailure extends Failure {
  static const networkFailure = Strings.networkFailure;

  const ConnectionFailure(String message) : super(message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(String message) : super(message);
}

mixin MessageError on Failure {
}
