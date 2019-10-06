import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent([List props = const []]);
}

///应用开始事件
class AppStartedEvent extends AuthenticationEvent {
  @override
  String toString() {
    return '应用开始事件';
  }

  @override
  List<Object> get props => [];
}

///登录事件
class LoggedInEvent extends AuthenticationEvent {
  final String token;

  LoggedInEvent({@required this.token});

  @override
  String toString() {
    return '登录事件{token: $token}';
  }

  @override
  List<Object> get props => [token];
}

///注销事件
class LoggedOutEvent extends AuthenticationEvent {
  @override
  String toString() {
    return '注销事件';
  }

  @override
  List<Object> get props => [];
}
