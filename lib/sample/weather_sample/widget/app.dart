import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/repositories/repository.dart';
import 'package:flutter_bloc_test/sample/weather_sample/weather/bloc.dart';

import 'weather.dart';

class App extends StatelessWidget {
  final WeatherRepository weatherRepository;

  const App({Key key, this.weatherRepository})
      : assert(weatherRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Weather',
      home: BlocProvider(
        builder: (context) {
          return WeatherBloc(weatherRepository: weatherRepository);
        },
        child: Weather(),
      ),
    );
  }
}
