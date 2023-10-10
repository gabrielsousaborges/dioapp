import 'package:dioapp/model/post_model.dart';
import 'package:dioapp/pages/comment_page.dart';
import 'package:dioapp/repository/posts/impl/post_http_repository.dart';
import 'package:dioapp/repository/posts/postRepository.dart';

import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  PostRepository postRepository = PostHttpRepository();
  var posts = <PostModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    carregarDados();
  }

  carregarDados() async {
    posts = await postRepository.getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Posts"),
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (_, index) {
          var post = posts[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => CommentPage(postId: post.id)));
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Card(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        post.body,
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ));
  }
}
