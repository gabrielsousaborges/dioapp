import 'package:dioapp/model/post_model.dart';

abstract class PostRepository {
  Future<List<PostModel>> getPosts();
}
