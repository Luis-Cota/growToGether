import 'package:flutter/material.dart';
import '../model/post.dart';

class PostView extends StatelessWidget {
  final Post post;
  
  const PostView({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Datos del Post"),
      ),
      body: Center(
        child: SizedBox(
          width: 400,
          height: 400,
          child: Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(width: 200, height: 200, child: Placeholder(),),
                const Divider(thickness: 3,),
                Container(
                  color: Theme.of(context).colorScheme.tertiaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Título: ',
                        style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 20),
                      ),
                      Text (post.title, 
                        style: TextStyle(fontStyle: FontStyle.italic, 
                          fontSize: 20.0,
                          color: Theme.of(context).colorScheme.onTertiaryContainer),),
                    ],),),
                const SizedBox(height: 5.0,),
                Container(
                  color: Theme.of(context).colorScheme.secondaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Cantante: ',
                        style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 15),
                      ),
                      Text (post.description, 
                        style: TextStyle(fontStyle: FontStyle.italic, 
                          fontSize: 15.0,
                          color: Theme.of(context).colorScheme.onSecondaryContainer),),
                    ],),),
                const SizedBox(height: 5.0,),
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Año de lanzamiento: ',
                        style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 12),
                      ),
                    ],),),
                const SizedBox(height: 5.0,),
                Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Género: ',
                        style: TextStyle(fontWeight: FontWeight.bold,
                          fontSize: 12),
                      ),
                     /* Text (post.image, 
                        style: TextStyle(fontStyle: FontStyle.italic, 
                          fontSize: 12.0,
                          color: Theme.of(context).colorScheme.onSecondaryContainer),),*/
                    ],),)],),),),));}}