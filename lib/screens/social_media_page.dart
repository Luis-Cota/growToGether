import 'package:flutter/material.dart';
import 'package:growtogether_ux/screens/post_form.dart';
import 'package:growtogether_ux/screens/post_view.dart';
import 'package:growtogether_ux/screens/user_profile.dart';
import '../model/post.dart';
import '../model/post_Manager.dart';
import 'package:provider/provider.dart';

class SocialMediaPage extends StatefulWidget {

  const SocialMediaPage({super.key});

  @override
  State<SocialMediaPage> createState() => _SocialMediaPageState();
}

class _SocialMediaPageState extends State<SocialMediaPage> {
  int selectedPost = 0;
  late PostManager posts;

  @override
  Widget build(BuildContext context) {
    posts = Provider.of<PostManager>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Biblioteca de Álbumes"),
        actions: [
          PopupMenuButton(
                itemBuilder:(context) => <PopupMenuEntry>[
                  const PopupMenuItem(
                    value: 1,
                    child: Text("Perfíl del usuario")),
                  const PopupMenuItem(
                    value: 2,
                    child: Text("Acerca de ...")),],
                onSelected: (value) {setState(() {
                  if (value == 1) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const UserProfile()));
                  } else if (value == 2) {

                    // Aquí se mostrará una página con datos de la aplicación
                  }});})],),
      body: (posts.posts.isNotEmpty)? ListView(
        padding: const EdgeInsets.all(10),
        children: ListTile.divideTiles(context: context, 
          tiles: crearLista(), color:Colors.amber).toList(),)
        : Padding(padding: const EdgeInsets.all(20.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                capturarAlbum(context);},
              child: const Text("Agregar Album"),)),),
      floatingActionButton: FloatingActionButton(
        onPressed: () { capturarAlbum(context); },
        tooltip: 'Nuevo album',
        child: const Icon(Icons.add),),);}

  List<Widget> crearLista() {
    final List<Widget> lista = <Widget>[];
    for(int i = 0; i < posts.posts.length; i++ ){
      Post post = posts.posts[i];
      lista.add(
        ListTile(
          leading: const Icon(Icons.album),
          title: Text(post.title),
          subtitle: Text("${post.title}, Año: ${post.date}, Género: ${post.description}"),
          trailing: SizedBox(width: 120,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: crearButtonsBar(i))),
          textColor: Colors.white,
          tileColor: Colors.lightBlue,
          selectedColor: Colors.blue,
          selectedTileColor: Colors.deepOrange.shade100,
          selected: (selectedPost == i),
          onTap: () => albumTapped(i)));}
    return lista;}

  void albumTapped(int i) {
    setState(() {
      selectedPost = i;});}

  Widget crearButtonsBar(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
    children: [
      IconButton(
        tooltip: "Ver",
        onPressed: () { mostrarAlbum(context, index); },
        icon: const Icon(Icons.search)),
      IconButton(
        tooltip: "Editar",
        onPressed: () { actualizarAlbum(context, index); }, 
        icon: const Icon(Icons.edit)),
      IconButton(
        tooltip: "Eliminar",
        onPressed: () { removerAlbum(index); }, 
        icon: const Icon(Icons.delete)),],);}

  Future<void> capturarAlbum(BuildContext context) async {
    final Post? post = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => const PostForm(),));

    if (post != null) {
      posts.addPost(post);
      posts.guardarposts();}}

  void mostrarAlbum(BuildContext context, int index) {
    Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => 
              PostView(post: posts.getPostByIndex(index),),));}



  
  Future<void> actualizarAlbum(BuildContext context, int index,) async {
    Post? post = await Navigator.push(context, 
      MaterialPageRoute(
        builder: (context) => PostForm(post: posts.getPostByIndex(index)),));

    if(post != null){
      posts.updatePost(index, post);
      posts.guardarposts();}}

  bool removerAlbum(int index) {
    bool res = posts.removePost(index);
    if (res) posts.guardarposts();
    return res;}}