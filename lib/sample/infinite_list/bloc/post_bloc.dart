import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc_test/sample/infinite_list/models/models.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import 'bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Dio dio;

  PostBloc({@required this.dio});

  @override
  Stream<PostState> transformEvents(
      Stream<PostEvent> events, Stream<PostState> next(PostEvent event)) {
    ///避免数据重复更新
    return super.transformEvents(
        (events as Observable<PostEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  PostState get initialState => PostUninitializedState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    ///当前为拉取事件且没到达底部
    if (event is FetchEvent && !_hasReachedMax(currentState)) {
      try {
        ///当前状态为帖子为未初始化状态
        if (currentState is PostUninitializedState) {
          ///拉取数据
          final posts = await _fetchPosts(0, 20);

          ///数据加载完成状态
          yield PostLoadedState(posts: posts, hasReachedMax: false);
          return;
        }
      } catch (err) {
        yield PostErrorState(err);
      }
    }
    if (event is FetchMoreEvent && !_hasReachedMax(currentState)) {
      try {
        ///当前状态为帖子已加载状态
        if (currentState is PostLoadedState) {
          ///从底部位置开始拉取数据
          final posts = await _fetchPosts(
              (currentState as PostLoadedState).posts.length, 20);

          ///数据加载完成，如果结果为空则无法获取更多数据
          yield posts.isEmpty
              ? (currentState as PostLoadedState).copyWith(hasReachedMax: true)

          ///否则拼接新旧数据
              : PostLoadedState(
              posts: (currentState as PostLoadedState).posts + posts,
              hasReachedMax: false);
        }
      } catch (err) {
        yield PostErrorState(err);
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoadedState && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int startIndex, int limit) async {
    try {
      Response response =
          await dio.get('/posts?_start=$startIndex&_limit=$limit');

      final list = response.data as List;
      return List<Post>.from(list.map((e) => Post.fromJson(e)).toList());
    } on DioError catch (err) {
      throw err;
    }
  }
}
