import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/theme/bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/weather/bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/city_selection.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/gradient_container.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/last_updated.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/location.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/weather_temperature.dart';

import 'settings.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  Completer<void> _refreshCompleter;

  @override
  void initState() {
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather BloC'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Settings()));
              }),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final city = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CitySelection()));
                if (city != null) {
                  weatherBloc.dispatch(FetchWeatherEvent(city: city));
                }
              })
        ],
      ),
      body: Center(
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherLoadedState) {
              BlocProvider.of<ThemeBloc>(context).dispatch(
                  WeatherChanged(weatherCondition: state.weather.condition));
              _refreshCompleter?.complete();
              _refreshCompleter = Completer();
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherEmptyState) {
                return Center(child: Text('请选择一个位置'));
              }
              if (state is WeatherLoadingState) {
                return Center(child: CircularProgressIndicator());
              }
              if (state is WeatherLoadedState) {
                final weather = state.weather;
                return BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return GradientContainer(
                      color: themeState.color,
                      child: RefreshIndicator(
                        onRefresh: () {
                          weatherBloc.dispatch(RefreshWeatherEvent(
                              city: state.weather.location));
                          return _refreshCompleter.future;
                        },
                        child: ListView(
                          children: <Widget>[
                            Center(child: Location(location: weather.location)),
                            Center(
                                child:
                                LastUpdated(dateTime: weather.lastUpdated)),
                            Center(
                                child: CombinedWeatherTemperature(
                                    weather: weather))
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
              if (state is WeatherErrorState) {
                return Text('出错了${state.err.toString()}');
              }
              return null;
            },
          ),
        ),
      ),
    );
  }
}
