import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_test/sample/weather_sample/settings/bloc.dart';

/**
 * Created by Komugi on 2019/10/14  20:25
 * @author Komugi
 */
class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final settingsBloc = BlocProvider.of<SettingsBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        children: <Widget>[
          BlocBuilder<SettingsBloc, SettingsState>(builder: (context, state) {
            return ListTile(
              title: Text('摄氏度'),
              isThreeLine: true,
              subtitle: Text('温度单位'),
              trailing: Switch(
                  value: state.temperatureUnits == TemperatureUnits.celsius,
                  onChanged: (val) =>
                      settingsBloc.dispatch(TemperatureUnitsToggled())),
            );
          })
        ],
      ),
    );
  }
}
