import 'package:cloud_firestore/cloud_firestore.dart';

class WikiItem {
  final String id;
  final String title;
  final String content;
  final List<String> mediaUrls;
  final DateTime date;

  WikiItem({
    required this.id,
    required this.title,
    required this.content,
    required this.mediaUrls,
    required this.date,
  });

  // Constructor para leer datos de Firestore
  factory WikiItem.fromMapId(String idC, Map<String, dynamic> json) {
    return WikiItem(
      id: idC,
      title: json['title'] as String? ?? 'Sin Título',
      content: json['content'] as String? ?? 'Sin Contenido',
      date: (json['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
      mediaUrls: (json['mediaUrls'] is Iterable)
          ? List<String>.from(json['mediaUrls'])
          : [],
    );
  }
}
