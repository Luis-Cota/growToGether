//import 'package:flutter/material.dart';
import 'home_page.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(

      
      
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return SignInScreen(



        footerBuilder: (context, action) {
          return Padding(
        padding: const EdgeInsetsDirectional.symmetric(),
                child: Container(
                  
          color: Theme.of(context).colorScheme.secondaryContainer,),);},
            subtitleBuilder: (context, action) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  action == AuthAction.signIn ?
                  "Bienvenido a la aplicación GrowToGether. Inicie sesión para continuar."
                  : "Si aún no tiene una cuenta, por favor regístrese para continuar."
                ),);},
            headerBuilder: (context, constraints, shrinkOffset) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Image.asset('assets/images/app_icon/icon.png'),);},);}
        return home_page();
        },);}}




/*
class loginPage extends StatefulWidget {
@override
loginPageState createState() => loginPageState();
}
//La pagina prinsipal donde declaro las variables
class loginPageState extends State<loginPage>{

  final TextEditingController _userNameTxT = TextEditingController();
  final TextEditingController _passwordTxT = TextEditingController();

//Aqui planeo implementar toda la logica del inicio de sesion
void _login(){

Navigator.push(
context,
MaterialPageRoute(builder: (context) => home_page()),
);

//String _name = _userNameTxT.text;
//String _password = _passwordTxT.text;
}

//Este es el widget de las barras de texto
Widget build(BuildContext context){

  return Container(
  //width: 500,
  //height: 400,
  decoration: BoxDecoration(
  image : DecorationImage(
  image : AssetImage("assets/images/background/background_login.jpg"),
  fit: BoxFit.cover,
  ),
  ),


  
  child: Scaffold(
    resizeToAvoidBottomInset: false,
    backgroundColor: Colors.transparent,
    appBar: AppBar(
      title: Text('Login'),
    ),
    body: Center(
      child: Column(


//Aqui esta todo el estilo junto con las barras de texto

 mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

SizedBox(width: 50,height: 50,),
Stack(
  clipBehavior: Clip.none,
  children: [



Container(
  width: 385,
  height: 750,
  decoration: BoxDecoration(
    color: Color.fromARGB(255, 255, 245, 215),
    border: Border.all(
      width: 2.5,
    ),
    borderRadius: BorderRadius.circular(15)
    )
    ),

Positioned( top:-75, left: 125,
  child:
  Container(
width: 125,
  height: 125,
decoration: BoxDecoration(
  image: DecorationImage(
    image:AssetImage("assets/images/app_icon/icon.png"),
    fit: BoxFit.cover
  )
    ),
),
),


Positioned(top: 150, left: 12,
  child: SizedBox(height: 96,
          width: 360,
          
           child:  TextField(
              controller: _userNameTxT,
              decoration: InputDecoration(
                labelText: "Usuario o correo electronico",
                border:OutlineInputBorder(),
              ),
              ),
              )
            
),

Positioned(top:250, left:12,
child: SizedBox(height: 96,
          width: 360,
          child: TextField(
              controller: _passwordTxT,
              decoration: InputDecoration(
                labelText: "Contraseña",
                border: OutlineInputBorder(),
              )

            )
            )
),
Positioned(top:550, left:130, child: 
            ElevatedButton(onPressed: _login,
             child: Text("Iniciar sesion"),
             
             
            )
             ),
          ],
          ),
          ],
        ),
      ),
  ));

}
//Esto es backgroun de las barras de texto

}
*/


