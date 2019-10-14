import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_test/sample/weather_sample/models/models.dart';

abstract class ThemeEvent extends Equatable {
  ThemeEvent([List props = const []]);
}

class WeatherChanged extends ThemeEvent {
  final WeatherCondition weatherCondition;

  WeatherChanged({@required this.weatherCondition})
      : assert(weatherCondition != null);

  @override
  List<Object> get props => [weatherCondition];
}
