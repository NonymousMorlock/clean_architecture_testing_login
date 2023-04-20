import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<dynamic> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({required String message, required this.statusCode})
      : super(message);

  final int statusCode;

  @override
  List<dynamic> get props => [message, statusCode];
}
