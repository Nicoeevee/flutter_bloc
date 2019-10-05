import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'post.dart';

@immutable
abstract class PostState extends Equatable {
  List<Post> posts;

  PostState(this.posts, [List props = const []]) : super();

  @override
  List<Object> get props => [posts];
}

class PostUninitializedState extends PostState {
  PostUninitializedState() : super(null);

  @override
  String toString() => 'PostUninitialized';
}

class PostErrorState extends PostState {
  PostErrorState() : super(null);

  @override
  String toString() => 'PostError';
}

class PostLoadedState extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoadedState({this.posts, this.hasReachedMax})
      : super(posts, [hasReachedMax]);

  PostLoadedState copyWith({List<Post> posts, bool hasReachedMax}) {
    return PostLoadedState(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
