import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/post_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:growtogether_ux/screens/login_page.dart';
import 'firebase_options.dart';
//import 'auth_1/view/pagina_login.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseUIAuth.configureProviders([EmailAuthProvider()]);
  FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.playIntegrity,
  );
  runApp(
    ChangeNotifierProvider(create: (_) => PostServices(), child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowToGether',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: const Color.fromARGB(255, 63, 247, 103),
          seedColor: const Color.fromARGB(255, 63, 247, 103),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}
