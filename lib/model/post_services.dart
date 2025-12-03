import 'post.dart';
import 'package:flutter/material.dart';
//import 'dart:convert';
//import 'dart:io';
//import 'package:path_provider/path_provider.dart';

class PostServices extends ChangeNotifier {
  final List<Post> _postlist = [];
  static String fileName = "posts.json";

  PostServices();

  List<Post> get posts => _postlist;

  Post getPostbyIndex(int index) => _postlist[index];

  void setPosts(List<Post> posts) {
    _postlist.clear();
    for (Post post in posts) {
      _postlist.add(post);
      notifyListeners();
    }
  }

  void addPost(Post post) {
    _postlist.add(post);
    notifyListeners();
  }

  bool updatePost(int index, Post post) {
    if (index >= 0 && index <= _postlist.length) {
      _postlist[index] = post;
      notifyListeners();
      return true;
    }
    return false;
  }

  bool deletePost(int index) {
    if (index >= 0 && index <= _postlist.length) {
      _postlist.remove(index);
      notifyListeners();
      return true;
    }
    return false;
  }
}
