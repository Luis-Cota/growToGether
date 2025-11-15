import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:growtogether_ux/screens/login_page.dart';
import 'firebase_options.dart';
//import 'auth_1/view/pagina_login.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
     await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform );
      FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
  ]);
  runApp(const MyApp());
  }
    class MyApp extends StatelessWidget {
      const MyApp({super.key});
        @override
       Widget build(BuildContext context) {
    return MaterialApp(
    title: 'Ejemplo firebase_auth',
    theme: ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 1, 140, 31)),
    primaryColor: Color.fromARGB(255, 63, 247, 103),
    useMaterial3: true,
 ),
  home: const LoginPage(),
);}}

