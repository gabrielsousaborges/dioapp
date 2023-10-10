import 'dart:convert';

import 'package:dioapp/model/post_model.dart';
import 'package:dioapp/repository/posts/postRepository.dart';
import 'package:http/http.dart' as http;

class PostHttpRepository implements PostRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var response =
        await http.get(Uri.parse("https://jsonplaceholder.typicode.com/posts"));

    if (response.statusCode == 200) {
      var jsonPosts = jsonDecode(response.body);
      return (jsonPosts as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
