import 'package:equatable/equatable.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
}

class FetchEvent extends PostEvent {
  @override
  String toString() => 'Fetch';

  @override
  List<Object> get props => null;
}
