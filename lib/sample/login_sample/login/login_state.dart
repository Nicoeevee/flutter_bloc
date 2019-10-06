import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]);
}

///初始登录状态
class InitialLoginState extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '初始登录状态';
  }
}

///加载登录状态
class LoadingLoginState extends LoginState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '加载登录状态';
  }
}

///失败登录状态
class FailureLoginState extends LoginState {
  final String error;

  FailureLoginState({@required this.error});

  @override
  String toString() => '失败登录状态 { error: $error }';

  @override
  List<Object> get props => [error];
}
