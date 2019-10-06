import 'package:equatable/equatable.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

///认证初始状态
class InitialState extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '认证初始状态';
  }
}

///认证尚未初始化状态
class UninitializedState extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '认证尚未初始化状态';
  }
}

///认证已验证状态
class AuthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '认证已验证状态';
  }
}

///认证未验证状态
class UnauthenticatedState extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '认证未验证状态';
  }
}

///认证加载状态
class LoadingState extends AuthenticationState {
  @override
  List<Object> get props => [];

  @override
  String toString() {
    return '认证加载中状态';
  }
}
