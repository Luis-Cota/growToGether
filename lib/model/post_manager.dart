import 'post.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class PostManager extends ChangeNotifier {
  final List<Post> _listaposts = [];
  static String fileName = "posts.json";

  PostManager();

  PostManager.fromJson(Map<String, dynamic> json) {
    List<dynamic> posts = json["posts"];
    for (int i = 0; i < posts.length; i++) {
      _listaposts.add(Post.fromJson(posts[i]));}}

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> posts = [];
    for (int i = 0; i < _listaposts.length ; i++) {
      posts.add(_listaposts[i].toJson());}
    Map<String, dynamic> mapa = {"posts": posts};
    return mapa;}

  List<Post> get posts => _listaposts;

  void addPost(Post Post) {
    _listaposts.add(Post);
    notifyListeners();}

  bool updatePost(int index, Post Post) {
    if (index >= 0 && index < _listaposts.length) {
      _listaposts[index] = Post;
      notifyListeners();
      return true;}
    return false;}

  bool removePost(int index) {
    if (index >= 0 && index < _listaposts.length) {
      _listaposts.removeAt(index);
      notifyListeners();
      return true;}
    return false;}

  Post getPostByIndex(int index) {
    return _listaposts[index];}
    
  static Future<String> get _pathLocal async {
    final directorio = await getApplicationDocumentsDirectory();
    return directorio.path;}

  static Future<File> get _archivoLocal async {
    final path = await _pathLocal;
    return File('$path${Platform.pathSeparator}$fileName');}

  Future<File> guardarposts() async{
    final archivo = await _archivoLocal;
    return archivo.writeAsString(jsonEncode(toJson()));}

  static Future<Map<String, dynamic>?> leerArchivo() async {
    final archivo = await _archivoLocal;
    if (archivo.existsSync()) {
      String contenido = await archivo.readAsString();
      return jsonDecode(contenido);}
    return null;}
}