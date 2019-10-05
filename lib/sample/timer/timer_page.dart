import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import 'bloc.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle =
      TextStyle(fontSize: 60, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Timer BloC'),
        ),
        body: Stack(
          children: <Widget>[
            Background(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: BlocBuilder<TimerBloc, TimerState>(
                      builder: (context, state) {
                    final String minutesStr = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final String secondsStr = (state.duration % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return Text(
                      '$minutesStr:$secondsStr',
                      style: Timer.timerTextStyle,
                    );
                  }),
                ),
                BlocBuilder<TimerBloc, TimerState>(
                  builder: (context, state) => Actions(),
                  condition: (previousState, currentState) =>
                      currentState.runtimeType != previousState.runtimeType,
                )
              ],
            ),
          ],
        ));
  }
}

class Actions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButton(
          timerBloc: BlocProvider.of<TimerBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButton({TimerBloc timerBloc}) {
    final TimerState state = timerBloc.currentState;
    if (state is ReadyState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () =>
              timerBloc.dispatch(StartEvent(totalTime: state.duration)),
        )
      ];
    }
    if (state is RunningState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.pause),
          onPressed: () => timerBloc.dispatch(PauseEvent()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(ResetEvent()),
        )
      ];
    }
    if (state is PausedState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () => timerBloc.dispatch(ResumeEvent()),
        ),
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(ResetEvent()),
        )
      ];
    }
    if (state is FinishedState) {
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: () => timerBloc.dispatch(ResetEvent()),
        )
      ];
    }
    return [];
  }
}

class Background extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WaveWidget(
      config: CustomConfig(
          gradients: [
            [
              Color.fromRGBO(72, 74, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(184, 189, 245, 0.7)
            ],
            [
              Color.fromRGBO(72, 74, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(172, 182, 219, 0.7)
            ],
            [
              Color.fromRGBO(72, 73, 126, 1),
              Color.fromRGBO(125, 170, 206, 1),
              Color.fromRGBO(190, 238, 246, 0.7)
            ],
          ],
          durations: [
            19440,
            10800,
            6000
          ],
          heightPercentages: [
            0.03,
            0.01,
            0.02
          ],
          gradientEnd: Alignment.topCenter,
          gradientBegin: Alignment.bottomCenter),
      size: Size(double.infinity, double.infinity),
      waveAmplitude: 25,
      backgroundColor: Colors.blue[50],
    );
  }
}
