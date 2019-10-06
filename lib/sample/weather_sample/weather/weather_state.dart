import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_test/sample/weather_sample/models/weather.dart';
import 'package:meta/meta.dart';

abstract class WeatherState extends Equatable {
  WeatherState([List props = const []]);
}

class WeatherEmptyState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoadedState extends WeatherState {
  final Weather weather;

  WeatherLoadedState({@required this.weather}) : assert(weather != null);

  @override
  List<Object> get props => [weather];
}

class WeatherErrorState extends WeatherState {
  var err;

  WeatherErrorState(this.err);

  @override
  List<Object> get props => [err];
}
