import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]);
}

///开始事件
///传入总时间
class StartEvent extends TimerEvent {
  final int totalTime;

  StartEvent({@required this.totalTime}) : super([totalTime]);

  @override
  List<Object> get props => props;

  @override
  String toString() => "Start { totalTime: $totalTime }";
}

///暂停事件
class PauseEvent extends TimerEvent {
  @override
  String toString() => "Pause";

  @override
  List<Object> get props => props;
}

///恢复事件
class ResumeEvent extends TimerEvent {
  @override
  String toString() => "Resume";

  @override
  List<Object> get props => props;
}

///重置事件
class ResetEvent extends TimerEvent {
  @override
  String toString() => "Reset";

  @override
  List<Object> get props => props;
}

///秒进事件
///传入剩余时间
class TickEvent extends TimerEvent {
  final int duration;

  TickEvent({@required this.duration}) : super([duration]);

  @override
  String toString() => "Tick { duration: $duration }";

  @override
  List<Object> get props => props;
}
