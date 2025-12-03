import 'package:flutter/material.dart';
import '../model/post.dart';

class PostView extends StatelessWidget {
  final Post post;

  const PostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(post.title)),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (post.mediaUrls.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.network(
                  post.mediaUrls[0],
                  fit: BoxFit.cover,
                  height: 250,
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(post.content),
            ),

            const Divider(),
            const Text(
              'Comentarios',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
