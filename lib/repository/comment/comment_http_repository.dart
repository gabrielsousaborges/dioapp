import 'dart:convert';

import 'package:dioapp/model/comment_model.dart';
import 'package:dioapp/repository/comment/comment_repository.dart';
import 'package:http/http.dart' as http;

class CommentHttpRepository implements CommentRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    var response = await http.get(Uri.parse(
        "https://jsonplaceholder.typicode.com/posts/$postId/comments"));
    if (response.statusCode == 200) {
      var jsonComment = jsonDecode(response.body);
      return (jsonComment as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
