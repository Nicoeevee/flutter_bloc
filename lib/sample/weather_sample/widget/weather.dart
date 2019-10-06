import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/weather/bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/city_selection.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/last_updated.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/location.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/weather_temperature.dart';

class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Weather BloC'),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.settings), onPressed: () {}),
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
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherEmptyState) {
              return Center(
                child: Text('请选择一个位置'),
              );
            }
            if (state is WeatherLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is WeatherLoadedState) {
              final weather = state.weather;
              return ListView(
                children: <Widget>[
                  Center(child: Location(location: weather.location)),
                  Center(child: LastUpdated(dateTime: weather.lastUpdated)),
                  Center(child: CombinedWeatherTemperature(weather: weather))
                ],
              );
            }
            if (state is WeatherErrorState) {
              return Text('出错了${state.err.toString()}');
            }
            return null;
          },
        ),
      ),
    );
  }
}
