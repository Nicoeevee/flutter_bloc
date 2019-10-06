import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]);
}

class LoginButtonPressedEvent extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressedEvent({@required this.username, @required this.password});

  @override
  List<Object> get props => [username, password];

  @override
  String toString() {
    return '登录按钮被按下事件 {username: $username, password: $password}';
  }
}
