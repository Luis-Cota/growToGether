import 'package:flutter/material.dart';
import 'dart:io';
import '../model/post.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../database_manager/database_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:growtogether_ux/database_manager/database_config.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  const PostForm({super.key, this.post});

  @override
  State<PostForm> createState() => _PostFormState();
}

class _PostFormState extends State<PostForm> {
  File? media;
  int i = 0;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController ctrTitle = TextEditingController();
  final TextEditingController ctrContent = TextEditingController();
  final DateTime datenow = DateTime.now();
  List<String> mediaUrls =
      []; // Esta lsita guarda las urls de todas las imagenes
  late final String titleForm;
  String? id;

  @override
  void initState() {
    if (widget.post != null) {
      titleForm = "Editar post";
      id = widget.post!.id;
      ctrTitle.text = widget.post!.title;
      ctrContent.text = widget.post!.content;
      mediaUrls = [...widget.post!.mediaUrls];
    } else {
      titleForm = "Nuevo Post";
    }
    super.initState();
  }

  @override
  void dispose() {
    ctrTitle.dispose();
    ctrContent.dispose();
    super.dispose();
  }

  Future<String> uploadImageToStorage(File file) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      Reference ref = FirebaseStorage.instance.ref().child("posts/$fileName");
      UploadTask uploadTask = ref.putFile(file);

      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();

      print("DEBUG URL Final: $downloadUrl"); // <-- Confirma que es https://
      return downloadUrl;
    } catch (e) {
      print("ERROR SUBIENDO IMAGEN: $e");
      return ""; // Devuelve vacío si hay error.
    }
  }

  // En _PostFormState
  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) return;
    File imageFile = File(pickedFile.path);

    final url = await uploadImageToStorage(imageFile);
    print("URL devuelta de Storage: $url");

    if (!mounted) return;

    if (url.isNotEmpty) {
      setState(() {
        mediaUrls.add(url); // Añade la URL a la lista local
        print("URL AÑADIDA a mediaUrls. Tamaño: ${mediaUrls.length}");
      });
    } else {
      print("La URL devuelta de Storage está vacía.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titleForm),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Título'),
                  controller: ctrTitle,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Proporcione un título para la publicacion';
                    }
                    if (value.length < 3) {
                      return 'El Titulo debe tener al menos 3 caracteres';
                    }
                    if (value.length > 31) {
                      return 'El Titulo no puede superar los 16 caracteres';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10, width: 10),

                TextFormField(
                  controller: ctrContent,
                  maxLines: 12,
                  minLines: 4,
                  decoration: InputDecoration(
                    labelText: "Contenido",
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "El contenido es obligatorio";
                    }
                    if (value.length < 4) {
                      return "El contenido debe tener al menos 10 caracteres";
                    }
                    if (value.length > 500) {
                      return "El contenido no puede superar los 500 caracteres";
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 10.0),

                ElevatedButton(
                  onPressed: () {
                    _selectImage(ImageSource.gallery);
                  },
                  child: const Text("Añade una imagen a tu post"),
                ),
                const SizedBox(height: 10.0),
                Text(
                  'Imágenes añadidas: ${mediaUrls.length}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                const SizedBox(height: 10.0),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: _validar,
                      child: const Text("Aceptar"),
                    ),
                    const SizedBox(width: 20.0),
                    ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: const Text("Cancelar"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _validar() async {
    if (!_formkey.currentState!.validate()) return;

    final String? currentUserId = FirebaseAuth.instance.currentUser?.uid;

    if (currentUserId == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error: Debes iniciar sesión para publicar.'),
        ),
      );
      return;
    }

    print(" DEBUG 3: Lista mediaUrls FINAL enviada a Firestore: $mediaUrls");
    final Post post = Post(
      ctrTitle.text,
      ctrContent.text,
      datenow,
      0,
      0,
      mediaUrls,
      currentUserId,
    );

    String id = "";
    try {
      // Intenta insertar el post en Firestore
      id = await DatabaseConfig.getInstance().insertPost(post);
      print("POST GUARDADO CON ID: $id");
    } catch (e) {
      print("ERROR AL GUARDAR EN FIRESTORE: $e");
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error al guardar el post: $e')));
    }

    if (!mounted) return;
    if (id.isNotEmpty) {
      Navigator.pop(context);
    }
  }
}
