import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

import './bloc.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final Dio dio;

  PostBloc({@required this.dio});

  @override
  Stream<PostState> transformEvents(
      Stream<PostEvent> events, Stream<PostState> next(PostEvent event)) {
    return super.transformEvents(
        (events as Observable<PostEvent>)
            .debounceTime(Duration(milliseconds: 500)),
        next);
  }

  @override
  PostState get initialState => PostUninitializedState();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is FetchEvent && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitializedState) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoadedState(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoadedState) {
          final posts = await _fetchPosts(
              (currentState as PostLoadedState).posts.length, 20);
          yield posts.isEmpty
              ? (currentState as PostLoadedState).copyWith(hasReachedMax: true)
              : PostLoadedState(
                  posts: (currentState as PostLoadedState).posts + posts,
                  hasReachedMax: false);
        }
      } catch (err) {
        yield PostErrorState();
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
