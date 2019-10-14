import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/repositories/repository.dart';
import 'package:flutter_bloc_test/sample/weather_sample/theme/bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/weather/bloc.dart';

import 'weather.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const App({Key key, this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, themeState) {
      return MaterialApp(
        title: 'Flutter Weather',
        theme: themeState.theme,
        //使用BlocProvider通过BlocProvider.of<ThemeBloc>(context)使ThemeBloc全局可用。
        home: BlocProvider(
          builder: (context) =>
              WeatherBloc(weatherRepository: weatherRepository),
          child: Weather(),
        ),
      );
    });
  }
}
