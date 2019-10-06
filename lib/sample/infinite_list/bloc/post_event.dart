import 'package:equatable/equatable.dart';

///帖子事件
abstract class PostEvent extends Equatable {
//  const PostEvent();
}

///拉取事件
class FetchEvent extends PostEvent {
  @override
  String toString() => '拉取事件';

  @override
  List<Object> get props => null;
}

///拉取更多事件
class FetchMoreEvent extends PostEvent {
  @override
  String toString() => '拉取更多事件';

  @override
  List<Object> get props => null;
}
