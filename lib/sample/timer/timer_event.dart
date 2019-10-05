import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]);
}

class StartEvent extends TimerEvent {
  final int duration;

  StartEvent({@required this.duration}) : super([duration]);

  @override
  List<Object> get props => props;

  @override
  String toString() => "Start { duration: $duration }";
}

class PauseEvent extends TimerEvent {
  @override
  String toString() => "Pause";

  @override
  List<Object> get props => props;
}

class ResumeEvent extends TimerEvent {
  @override
  String toString() => "Resume";

  @override
  List<Object> get props => props;
}

class ResetEvent extends TimerEvent {
  @override
  String toString() => "Reset";

  @override
  List<Object> get props => props;
}

class TickEvent extends TimerEvent {
  final int duration;

  TickEvent({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";

  @override
  List<Object> get props => props;
}
