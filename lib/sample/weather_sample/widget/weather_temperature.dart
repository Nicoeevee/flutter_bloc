import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/models/models.dart'
    as model;
import 'package:flutter_bloc_test/sample/weather_sample/settings/bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/temperature.dart';
import 'package:flutter_bloc_test/sample/weather_sample/widget/weather_conditions.dart';

class CombinedWeatherTemperature extends StatelessWidget {
  final model.Weather weather;

  CombinedWeatherTemperature({
    Key key,
    @required this.weather,
  })  : assert(weather != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: WeatherConditions(condition: weather.condition),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: BlocBuilder<SettingsBloc, SettingsState>(
                  builder: (context, state) {
                    return Temperature(
                      units: state.temperatureUnits,
                      temperature: weather.temp,
                      high: weather.maxTemp,
                      low: weather.minTemp,
                    );
                  },
                ),
              ),
            ],
          ),
          Center(
            child: Text(
              weather.formattedCondition,
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w200,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
