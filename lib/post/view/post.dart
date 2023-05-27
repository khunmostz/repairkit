import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/post/controller/post.controller.dart';
import 'package:get/get.dart';

class Post extends GetView<PostController> {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Post'),
      ),
    );
  }
}
