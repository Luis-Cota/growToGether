import 'package:flutter/material.dart';
import 'package:growtogether_ux/database_manager/database_config.dart';
import 'package:growtogether_ux/screens/post_form.dart';
import 'package:growtogether_ux/screens/post_view.dart';
//import 'package:growtogether_ux/screens/user_profile.dart';
import '../model/post.dart';
import '../model/post_services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';

class SocialMediaPage extends StatefulWidget {
  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int selectedPost = 0;
  bool dbRead = false;
  late PostServices posts;
  late DatabaseConfig dbConfig;

  @override
  void initState() {
    super.initState();
    dbConfig = DatabaseConfig.getInstance();
  }

  @override
  Widget build(BuildContext context) {
    posts = Provider.of<PostServices>(context);

    if (!dbRead) {
      dbConfig.posts().then((value) {
        posts.setPosts(value);
        dbRead = true;
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text("Publicaciones :"),
        actions: [],
      ),
      body: !dbRead
          ? const Center(child: CircularProgressIndicator())
          : (posts.posts.isNotEmpty)
          ? ListView(
              padding: const EdgeInsets.all(10),
              children: ListTile.divideTiles(
                context: context,
                tiles: createList(),
                color: const Color.fromARGB(255, 0, 0, 0),
              ).toList(),
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    capturePost(context);
                  },
                  child: const Text("Agregar Post"),
                ),
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          capturePost(context);
        },
        tooltip: 'Nuevo Post',
        child: const Icon(Icons.add),
      ),
    );
  }

  List<Widget> createList() {
    final List<Widget> list = <Widget>[];
    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;
    for (int i = 0; i < posts.posts.length; i++) {
      Post post = posts.posts[i];
      final bool isCreator =
          currentUserId != null && currentUserId == post.idCreator;
      String? firstUrl =
          (post.mediaUrls != List.empty() && post.mediaUrls.isNotEmpty)
          ? post.mediaUrls[0]
          : null;
      list.add(
        ListTile(
          leading: (firstUrl != null && firstUrl.startsWith('http'))
              ? Image.network(
                  firstUrl,
                  width: 80,
                  height: 80,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 1),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      MdiIcons.flowerTulip,
                      color: const Color.fromARGB(255, 0, 0, 0),
                    );
                  },
                )
              : Icon(
                  MdiIcons.flowerTulip,
                  color: const Color.fromARGB(255, 0, 0, 0),
                ),
          title: Text(
            post.title,
            maxLines: 1,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        post.content,
                        maxLines: 4,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Icon(
                    MdiIcons.cardsHeart,
                    size: 16.0,
                    color: const Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text('${post.likes}'),

                  const SizedBox(width: 16),

                  const Icon(
                    Icons.calendar_today,
                    size: 16.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  Text(DateFormat('dd/MM/yyyy hh:mm a').format(post.date)),

                  const SizedBox(width: 16),

                  const Icon(
                    Icons.comment,
                    size: 16.0,
                    color: Color.fromARGB(255, 0, 0, 0),
                  ),
                  const Text('0'),
                ],
              ),
            ],
          ),

          trailing: SizedBox(
            width: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: isCreator
                  ? crearButtonsBar(i)
                  : const SizedBox.shrink(), // Ocultar el botón si no es el creador
            ),
          ),
          textColor: const Color.fromARGB(255, 0, 52, 33),
          tileColor: const Color.fromARGB(255, 255, 255, 255),
          selectedColor: const Color.fromARGB(255, 0, 0, 0),
          selectedTileColor: const Color.fromARGB(255, 202, 255, 202),
          selected: (selectedPost == i),
          onTap: () => showPost(context, i),
        ),
      );

      Divider();
    }
    return list;
  }

  void albumTapped(int i) {
    setState(() {
      selectedPost = i;
    });
  }

  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
          tooltip: "Editar",
          onPressed: () {
            updatePost(context, index);
          },
          icon: const Icon(Icons.edit),
        ),
        IconButton(
          tooltip: "Eliminar",
          onPressed: () {
            removePost(index);
          },
          icon: const Icon(Icons.delete),
        ),
      ],
    );
  }

  Future<void> capturePost(BuildContext context) async {
    final Post? post = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const PostForm()),
    );

    if (post != null) {
      String id = await dbConfig.insertPost(post);
      post.setId(id);
      posts.addPost(post);
    }
  }

  void showPost(BuildContext context, int index) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PostView(post: posts.getPostbyIndex(index)),
      ),
    );
  }

  Future<void> updatePost(BuildContext context, int index) async {
    Post? post = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PostForm(post: posts.getPostbyIndex(index)),
      ),
    );

    if (post != null) {
      posts.updatePost(index, post);
      dbConfig.updatePost(post);
    }
  }

  bool removePost(int index) {
    Post post = posts.getPostbyIndex(index);
    bool remove = posts.deletePost(index);
    dbConfig.deletePost(post.id!);
    return remove;
  }
}
