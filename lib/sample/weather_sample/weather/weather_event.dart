import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class WeatherEvent extends Equatable {
  WeatherEvent([List props = const []]);
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  FetchWeatherEvent({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}

class RefreshWeatherEvent extends WeatherEvent {
  final String city;

  RefreshWeatherEvent({@required this.city}) : assert(city != null);

  @override
  List<Object> get props => [city];
}
