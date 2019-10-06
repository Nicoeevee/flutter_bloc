import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/sample/login_sample/authentication/authentication.dart';
import 'package:flutter_bloc_test/sample/login_sample/authentication/authentication_bloc.dart';
import 'package:flutter_bloc_test/sample/user_repository/lib/user_repository.dart';
import 'package:meta/meta.dart';

import './login.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressedEvent) {
      yield LoadingLoginState();
      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);
        authenticationBloc.dispatch(LoggedInEvent(token: token));
        yield InitialLoginState();
      } catch (err) {
        yield FailureLoginState(error: err.toString());
      }
    }
  }
}
