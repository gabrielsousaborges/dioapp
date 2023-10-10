import 'package:dioapp/model/comment_model.dart';
import 'package:dioapp/repository/comment/comment_http_repository.dart';
import 'package:dioapp/repository/comment/comment_repository.dart';
import 'package:dioapp/repository/comment/impl/comment_dio_repository.dart';
import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final int postId;
  const CommentPage({super.key, required this.postId});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  late CommentRepository commentRepository;
  var comments = <CommentModel>[];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    commentRepository = CommentDIORepository();
    carregarDados();
  }

  carregarDados() async {
    comments = await commentRepository.retornaComentarios(widget.postId);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text("Comentarios do Post: ${widget.postId}"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: comments.length == 0
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: comments.length,
                itemBuilder: (_, int index) {
                  var comment = comments[index];
                  return Card(
                      child: Container(
                    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(comment.name.substring(0, 6)),
                            Text(comment.email),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(comment.body),
                      ],
                    ),
                  ));
                }),
      ),
    ));
  }
}
