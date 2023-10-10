import 'dart:convert';

import 'package:dioapp/model/post_model.dart';
import 'package:dioapp/repository/jsonplaceholder_dio.dart';
import 'package:dioapp/repository/posts/postRepository.dart';
import 'package:dio/dio.dart';

class PostDIORepository implements PostRepository {
  @override
  Future<List<PostModel>> getPosts() async {
    var jsonPlaceHolderDIO = JsonPlaceHolderDIO();
    var response = await jsonPlaceHolderDIO.dio.get("/posts");

    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
