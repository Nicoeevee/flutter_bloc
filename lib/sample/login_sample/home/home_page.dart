import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/login_sample/authentication/authentication.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body: Container(
        child: Center(
          child: OutlineButton(
            onPressed: () {
              authenticationBloc.dispatch(LoggedOutEvent());
            },
            child: Text('注销'),
          ),
        ),
      ),
    );
  }
}
