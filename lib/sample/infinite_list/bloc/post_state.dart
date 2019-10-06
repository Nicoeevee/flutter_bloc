import 'package:equatable/equatable.dart';

import '../models/post.dart';

///帖子状态
abstract class PostState extends Equatable {
  final List<Post> posts;
  final bool hasReachedMax;

  ///仅比较posts是否相同
  PostState({this.posts, this.hasReachedMax});

  @override
  List<Object> get props => [posts, hasReachedMax];
}

///帖子未初始化状态
class PostUninitializedState extends PostState {
  PostUninitializedState() : super();

  @override
  String toString() => '帖子未初始化状态';
}

///帖子错误状态
class PostErrorState extends PostState {
  final Exception err;

  PostErrorState(this.err) : super();

  @override
  String toString() => '帖子错误状态 ${err.toString()}';
}

///帖子加载完毕状态
class PostLoadedState extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoadedState({this.posts, this.hasReachedMax})
      : super(posts: posts, hasReachedMax: hasReachedMax);

  ///状态复制方法
  PostLoadedState copyWith({List<Post> posts, bool hasReachedMax}) {
    return PostLoadedState(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() =>
      '帖子加载完毕状态 { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
