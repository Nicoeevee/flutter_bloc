import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/sample/user_repository/lib/user_repository.dart';
import 'package:meta/meta.dart';

import 'authentication.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null);

  ///认证初始状态
  @override
  AuthenticationState get initialState => InitialState();

  ///将事件映射到状态的逻辑
  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    ///应用开始事件->寻找Token->已认证状态:未认证状态
    if (event is AppStartedEvent) {
      final bool hasToken = await userRepository.hasToken();

      yield hasToken ? AuthenticatedState() : UnauthenticatedState();
    }

    ///登录事件->加载认证状态->存储Token->已认证状态
    if (event is LoggedInEvent) {
      yield LoadingState();
      await userRepository.persistToken(event.token);
      yield AuthenticatedState();
    }

    ///注销事件->加载认证状态->删除Token->未认证状态
    if (event is LoggedOutEvent) {
      yield LoadingState();
      await userRepository.deleteToken();
      yield UnauthenticatedState();
    }
  }
}
