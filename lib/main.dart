import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/login_sample/common/common.dart';
import 'package:flutter_bloc_test/sample/login_sample/home/home_page.dart'
as authPage;
import 'package:flutter_bloc_test/sample/login_sample/login/login_page.dart';
import 'package:flutter_bloc_test/sample/user_repository/lib/src/user_repository.dart';

import 'sample/login_sample/authentication/authentication.dart';
import 'sample/login_sample/splash/splash.dart';

void main() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
  final UserRepository userRepository = UserRepository();
  runApp(BlocProvider<AuthenticationBloc>(
    builder: (context) {
      ///应用开始事件
      return AuthenticationBloc(userRepository: userRepository)
        ..dispatch(AppStartedEvent());
    },
    child: MyApp(userRepository: userRepository),
  ));
}

class SimpleBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    print('事件：$event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('转移：$transition');
  }

  @override
  void onError(Bloc bloc, Object error, StackTrace stacktrace) {
    super.onError(bloc, error, stacktrace);
    print('出错：$error');
  }
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter BloC Demo',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
//      home: BlocProvider<CounterBloc>(
//        builder: (context) => CounterBloc(),
//        child: CounterPage(),
//      ),
//      home: BlocProvider(
//        builder: (context) => TimerBloc(ticker: Ticker()),
//        child: Timer(),
//      ),
//      home: Scaffold(
//        appBar: AppBar(
//          title: Text('Posts BloC'),
//        ),
//        body: BlocProvider(
//          builder: (context) {
//            return PostBloc(dio: crateDio())..dispatch(FetchEvent());
//          },
//          child: HomePage(),
//        ),
//      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, state) {
            if (state is AuthenticatedState) {
              return authPage.HomePage();
            }
            if (state is UnauthenticatedState) {
              return LoginPage(userRepository: userRepository);
            }
            if (state is LoadingState) {
              return LoadingIndicator();
            }
            return SplashPage();
          }),
    );
  }
}
