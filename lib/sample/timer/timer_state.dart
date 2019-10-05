import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

///注意，所有的TimerStates都扩展了具有duration属性的抽象基类TimerState。这是因为无论我们的TimerBloc处于什么状态，我们都想知道还剩下多少时间。
@immutable
abstract class TimerState extends Equatable {
  final int duration;

  TimerState(this.duration, [List props = const []]) : super();

  @override
  List<Object> get props => [duration];
}

class Ready extends TimerState {
  Ready(int duration) : super(duration);

  @override
  String toString() => 'Ready { duration: $duration }';
}

class Paused extends TimerState {
  Paused(int duration) : super(duration);

  @override
  String toString() => 'Paused { duration: $duration }';
}

class Running extends TimerState {
  Running(int duration) : super(duration);

  @override
  String toString() => 'Running { duration: $duration }';
}

class Finished extends TimerState {
  Finished() : super(0);

  @override
  String toString() => 'Finished';
}
