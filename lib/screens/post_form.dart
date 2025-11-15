import 'package:flutter/material.dart';
import 'dart:io';
import '../model/post.dart';
import 'package:image_picker/image_picker.dart';

class PostForm extends StatefulWidget {
  final Post? post;
  const PostForm({super.key, this.post});

  @override
  State<PostForm> createState() => _PostFormState();}

class _PostFormState extends State<PostForm> {
  File? _imageFile;
  String? imagePath;
  final DateTime datenow = DateTime.now();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final TextEditingController ctrTitle = TextEditingController();
  final TextEditingController ctrDescription = TextEditingController();
  late final String titleForm;

  @override
  void initState(){
    if (widget.post != null) {
      ctrTitle.text = widget.post!.title;
      ctrDescription.text = widget.post!.description;
    } else {
      titleForm = "Nuevo Post";}
    super.initState();}

  @override
  void dispose() {
    ctrTitle.dispose();
    ctrDescription.dispose();
    super.dispose();}
    

  Future<void> _selectImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
        imagePath = pickedFile.path; 
      } else {
        print('No se seleccionó ninguna imagen.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(titleForm),),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Form(
            key: _formkey,
            child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'Título de la publicacion',),
                  controller: ctrTitle,
                  validator: (String? valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Proporcione un título para la publicacion';
                    } return null;},),
                const SizedBox(height: 10.0,),
                TextFormField(
                  decoration: const InputDecoration(
                    hintText: 'descirpcion de la Publicacion',),
                  controller: ctrDescription,
                  validator: (String? valor) {
                    if (valor == null || valor.isEmpty) {
                      return 'Proporcione un intérprete para el Post';
                    } return null;},),
                const SizedBox(height: 10.0,),


                SizedBox(width: 250,height: 250,
                child: IconButton(onPressed: (){_selectImage(ImageSource.gallery);}, icon: Icon(Icons.image)),
                ),

                const SizedBox(height: 10.0,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  ElevatedButton(
                    onPressed: _validar, 
                    child: const Text("Aceptar")),
                  const SizedBox(width: 20.0,),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(), 
                    child: const Text("Cancelar")),],)]),)),));}

  void _validar() {
    final form = _formkey.currentState;
    if (form?.validate() == false) {
      return;}
    final Post post = Post(
        ctrTitle.text,
        ctrDescription.text,
        datenow,
        imagePath
        );
    Navigator.pop(context, post);}}