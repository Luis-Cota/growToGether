import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/wiki_item.dart';

class DatabaseConfig {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static const String wikiCollection = 'gtgWiki';

  Stream<List<WikiItem>> getWikiStream() {
    return _firestore
        .collection(wikiCollection)
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return WikiItem.fromMapId(doc.id, doc.data());
          }).toList();
        });
  }
}
