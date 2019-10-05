import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc_test/sample/timer/ticker.dart';

import './bloc.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  final int _duration = 60;

  StreamSubscription<int> _tickerSubscription;

  TimerBloc({@required Ticker ticker})
      : assert(ticker != null),
        _ticker = ticker;

  @override
  TimerState get initialState => ReadyState(_duration);

  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is StartEvent) {
      //yield* 递归优化
      yield* _mapStartToState(event);
    } else if (event is PauseEvent) {
      yield* _mapPauseToState(event);
    } else if (event is ResumeEvent) {
      yield* _mapResumeToState(event);
    } else if (event is ResetEvent) {
      yield* _mapResetToState(event);
    } else if (event is TickEvent) {
      yield* _mapTickToState(event);
    }
  }

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }

  ///异步
  ///当TimerBloc收到Start事件时，它将推送一个Running状态伴随开始时间，
  ///此外，如果_tickerSubscription存在则释放之。另外还要重载TimerBloc的
  ///dispose，以便在TimerBloc被释放时取消_tickerSubscription。最后，
  ///监听_ticker.tick Stream ，每tick一次就发送一个Tick事件和剩余持续时间
  Stream<TimerState> _mapStartToState(StartEvent start) async* {
    yield RunningState(start.duration);
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker.tick(duration: start.duration).listen((duration) {
          dispatch(TickEvent(duration: duration));
    });
  }

  ///每当接收到Tick事件时，如果持续时间大于0，就推送Running状态并附带新的持续时间。否则，如果持续时间为0，推送Finished状态
  Stream<TimerState> _mapTickToState(TickEvent tick) async* {
    yield tick.duration > 0 ? RunningState(tick.duration) : FinishedState();
  }

  ///将暂停事件映射为已经暂停状态
  ///需要处于正在运行状态
  Stream<TimerState> _mapPauseToState(PauseEvent pause) async* {
    final state = currentState;
    if (state is RunningState) {
      _tickerSubscription?.pause();
      yield PausedState(state.duration);
    }
  }

  ///将恢复事件映射为运行状态
  ///需要处于已经暂停状态
  Stream<TimerState> _mapResumeToState(ResumeEvent resume) async* {
    final state = currentState;
    if (state is PausedState) {
      _tickerSubscription?.resume();
      yield RunningState(state.duration);
    }
  }

  ///将重置事件映射为准备状态
  Stream<TimerState> _mapResetToState(ResetEvent reset) async* {
    _tickerSubscription?.cancel();
    yield ReadyState(_duration);
  }
}
