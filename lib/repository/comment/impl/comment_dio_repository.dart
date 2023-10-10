import 'package:dio/dio.dart';
import 'package:dioapp/model/comment_model.dart';
import 'package:dioapp/repository/comment/comment_repository.dart';
import 'package:dioapp/repository/jsonplaceholder_dio.dart';

class CommentDIORepository implements CommentRepository {
  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    var jsonPlaceHolderDIO = JsonPlaceHolderDIO();
    var response = await jsonPlaceHolderDIO.dio.get("/posts/$postId/comments");

    return (response.data as List)
        .map((e) => CommentModel.fromJson(e))
        .toList();
  }
}
