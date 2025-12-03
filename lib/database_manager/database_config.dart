import '../model/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseConfig {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  static const String colectionName = 'Post';
  static CollectionReference collection = db.collection("gtgPosts");
  static final DatabaseConfig _instance = DatabaseConfig._();

  DatabaseConfig._();

  static DatabaseConfig getInstance() {
    return _instance;
  }

  Future<String> insertPost(Post post) async {
    String answer = "";
    await collection.add(post.toMap()).then((doc) {
      answer = doc.id;
    });
    return answer;
  }

  Future<List<Post>> posts() async {
    QuerySnapshot snapshot = await collection.get();
    final List<QueryDocumentSnapshot> docs = snapshot.docs;
    List<Post> listPost = [];
    for (int i = 0; i < docs.length; i++) {
      DocumentSnapshot doc = docs[i];
      String id = doc.id;
      Map<String, dynamic> information = doc.data() as Map<String, dynamic>;
      Post post = Post.fromMapId(id, information);
      listPost.add(post);
    }
    return listPost;
  }

  Stream<List<Post>> postsStream() {
    return collection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Post.fromMapId(doc.id, data);
      }).toList();
    });
  }

  Future<void> updatePost(Post post) async {
    await collection
        .doc(post.id)
        .set(post.toMap())
        .onError(
          (error, stackTrace) => print("Error al actualizar post ${post.id}"),
        );
  }

  Future<void> deletePost(String id) async {
    await collection
        .doc(id)
        .delete()
        .onError(
          (error, stackTrace) =>
              print("Ocurrio un error al intentar eliminar el post $id"),
        );
  }
}
