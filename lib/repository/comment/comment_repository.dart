import 'package:dioapp/model/comment_model.dart';

abstract class CommentRepository {
  Future<List<CommentModel>> retornaComentarios(int postId);
}
