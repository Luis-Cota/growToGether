import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:growtogether_ux/screens/login_page.dart';
import 'edit_user_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, this.user});
  final User? user;

  final String name = "Lobito021";
  final int follwers = 5;
  final int followings = 3;
  final int post = 0;
  final String email = "l22330862@gmial.com";
  final String tel = "+552 662 413 82";
  final String description =
      "Mi tirada es convertir cada rincón en un chulada de jardín. No le saco al solazo ni a ensuciarme las manos con la tierra. Soy el mero pipiolo de las flores, los árboles y las yerbitas. Dicen que el que es perico donde quiera es verde, ¡y yo estoy más verde que un aguacate en esto de la jardinería! Me encanta compartir los secretos para que tus plantas no se achicopalen. Si tienes dudas, pregunta sin broncas. ¡Arre con la que barre!";

  void follows() {}

  @override
  Widget build(BuildContext context) {
    return (user == null)
        ? const LoginPage()
        : Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).colorScheme.onPrimary,
              title: Text(
                name,
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),

              actions: [
                PopupMenuButton(
                  itemBuilder: (context) => <PopupMenuEntry>[
                    const PopupMenuItem(value: 1, child: Text("Cerrar sesion")),
                    const PopupMenuItem(value: 2, child: Text("Acerca de ...")),
                  ],
                  onSelected: (value) async {
                    if (value == 1) {
                      {
                        await FirebaseAuth.instance.signOut();
                        LoginPage();
                      }
                    } else if (value == 2) {
                      // Aquí se mostrará una página con datos de la aplicación
                    }
                    ;
                  },
                ),
              ],
            ),
            body: Flexible(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.onInverseSurface,
                            border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.asset(
                              'assets/images/user_profile_image.jpg',
                            ),
                          ),
                        ),

                        Spacer(),

                        SizedBox(
                          width: 100,
                          height: 100,
                          child: TextButton(
                            onPressed: follows,
                            child: Text(
                              "Sigiendo: \n $followings",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),

                        Spacer(),

                        SizedBox(
                          width: 100,
                          height: 100,
                          child: TextButton(
                            onPressed: follows,
                            child: Text(
                              "Segidores \n $follwers",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),

                        Spacer(),

                        SizedBox(
                          width: 125,
                          height: 100,
                          child: TextButton(
                            onPressed: follows,
                            child: Text(
                              "Publicaciones \n $post",
                              style: Theme.of(context).textTheme.titleMedium!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    Divider(),
                    SizedBox(
                      width: 180,
                      child: FloatingActionButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditUserProfile(user: user),
                            ),
                          );
                        },
                        child: Text(
                          "Editar Perfil",
                          style: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ),
                    ),

                    Text(
                      "Contacto:",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Email: $email\nTel: $tel",
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 50),
                    SizedBox(
                      child: Text(
                        description,
                        style: Theme.of(context).textTheme.titleMedium!
                            .copyWith(fontWeight: FontWeight.w800),
                      ),
                    ),

                    SizedBox(),
                  ],
                ),
              ),
            ),
          );
  }
}
