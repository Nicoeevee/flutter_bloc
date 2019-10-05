import 'package:equatable/equatable.dart';

class Post extends Equatable {
  String title;
  String body;
  int userId;
  int id;

  Post({this.title, this.body, this.userId, this.id});

  Post.fromJson(Map<String, dynamic> json) {
    this.title = json['title'];
    this.body = json['body'];
    this.userId = json['userId'];
    this.id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['body'] = this.body;
    data['userId'] = this.userId;
    data['id'] = this.id;
    return data;
  }

  @override
  List<Object> get props => [id, title, body];
}
