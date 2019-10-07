import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_test/repositories/repository.dart';
import 'package:flutter_bloc_test/sample/weather_sample/models/models.dart';
import 'package:meta/meta.dart';

import './bloc.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository weatherRepository;

  WeatherBloc({@required this.weatherRepository})
      : assert(weatherRepository != null);

  @override
  WeatherState get initialState => WeatherEmptyState();

  @override
  Stream<WeatherState> mapEventToState(
    WeatherEvent event,
  ) async* {
    if (event is FetchWeatherEvent) {
      yield WeatherLoadingState();
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoadedState(weather: weather);
      } catch (err) {
        yield WeatherErrorState(err);
      }
    }

    if (event is RefreshWeatherEvent) {
      try {
        final Weather weather = await weatherRepository.getWeather(event.city);
        yield WeatherLoadedState(weather: weather);
        print('meme');
      } catch (err) {
        yield currentState;
        print('memeerr');
      }
    }
  }
}
