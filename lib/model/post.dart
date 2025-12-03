//import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String? _id;
  String _title;
  String _content;
  DateTime _date;
  int _likes;
  int _dislikes;
  List<String>? _comments;
  List<String> _mediaUrls = [];
  String _idCreator;

  Post(
    this._title,
    this._content,
    this._date,
    this._likes,
    this._dislikes,
    //this._comments,
    this._mediaUrls,
    this._idCreator, {
    String? id, // <-- Aquí se usa el nombre público 'id'
  }) : _id = id;

  Post.vacio({
    String id = "0",
    String title = "",
    String content = "",
    DateTime? date,
    int likes = 0,
    int dislikes = 0,
    List<String>? comments,
    List<String>? mediaUrls,
    String idCreator = "",
  }) : _id = id,
       _title = title,
       _content = content,
       _date = date ?? DateTime.now(),
       _likes = likes,
       _dislikes = dislikes,
       //_comments = comments ?? [],
       _mediaUrls = mediaUrls ?? [],
       _idCreator = idCreator;

  Post.fromSnapshot(DocumentSnapshot doc)
    : _id = doc.id,
      _title = doc['title'] ?? "",
      _content = doc['content'] ?? "",
      _date = (doc['date'] is Timestamp)
          ? (doc['date'] as Timestamp).toDate()
          : (doc['date'] ?? DateTime.now()),
      _likes = doc['likes'] ?? 0,
      _dislikes = doc['dislikes'] ?? 0,
      //  _comments = List<String>.from(doc['comments'] ?? []),
      _mediaUrls = List<String>.from(doc['mediaUrls'] ?? []),
      _idCreator = doc['title'] ?? "";

  Post.fromMap(Map<String, dynamic> json)
    : _id = json['id'],
      _title = json['title'],
      _content = json['content'],
      _date = json['date'],
      _likes = json['likes'],
      _dislikes = json['dislikes'],
      // _comments = json['comments'],
      _mediaUrls = json['mediaUrls'],
      _idCreator = json['idCreator'];

  Post.fromMapId(String idC, Map<String, dynamic> json)
    : _id = idC,
      _title = json['title'],
      _content = json['content'],
      _date = (json['date'] is Timestamp)
          ? (json['date'] as Timestamp).toDate()
          : DateTime.now(),
      _likes = json['likes'],
      _dislikes = json['dislikes'],
      // _comments = json['comments'],
      _mediaUrls = json['mediaUrls'] != null
          ? List<String>.from(json['mediaUrls'])
          : [],
      _idCreator = json['idCreator'];

  Map<String, dynamic> toMap() => {
    'title': _title,
    'content': _content,
    'date': Timestamp.fromDate(_date),
    'likes': _likes,
    'dislikes': _dislikes,
    //'comments': _comments,
    'mediaUrls': _mediaUrls,
    'idCreator': _idCreator,
  };

  setId(String id) {
    this._id = id;
  }

  setTitle(String title) {
    this._title = title;
  }

  setContent(String content) {
    this._content = content;
  }

  setDate(DateTime date) {
    this._date = date;
  }

  setLikes(int likes) {
    this._likes = likes;
  }

  setDislikes(int dislikes) {
    this._dislikes = dislikes;
  }

  setComments(List<String>? comments) {
    this._comments = comments;
  }

  setMediaUrls(List<String> mediaUrls) {
    this._mediaUrls = mediaUrls;
  }

  setMediaIdcreador(String idCreator) {
    this._idCreator = idCreator;
  }

  String? get id => _id;
  String get title => _title;
  String get content => _content;
  DateTime get date => _date;
  int get likes => _likes;
  int get dislikes => _dislikes;
  List<String>? get comments => _comments;
  List<String> get mediaUrls => _mediaUrls;
  String get idCreator => _idCreator;

  @override
  String toString() {
    return "Album{id: $_id, title: $_title, content, $_content, date: $_date, likes $_likes, dislikes: $dislikes, comments: $comments, mediaUrls:$_mediaUrls, idCreator: $_idCreator}";
  }
}
