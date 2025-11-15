import 'package:flutter/material.dart';
import 'package:growtogether_ux/screens/login_page.dart';
import 'ia_page.dart';
import 'social_media_page.dart';
import 'user_profile.dart';
import 'wiki_page.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';

class home_page extends StatefulWidget {
@override
  home_pageState createState() => home_pageState();
  }

  class home_pageState extends State<home_page> {

    

    int setIndex = 0;

void ia_function(){

}

void wiki_function(){

}

void sosial_media_function(){

}

void user_profile(){

}

Widget build(BuildContext context){
   return MaterialApp(
      title: 'Home page',
    

    home: Scaffold(
      appBar: AppBar(
        title: Text("Home page")),
        bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
            setState(() {
              setIndex = index;
            }
          );
        },
        selectedIndex: setIndex,
        destinations: const <Widget>[

          NavigationDestination(
            icon: Icon(Icons.camera_alt, size: 50),
             label: 'Ia Camera'),
             
          NavigationDestination(
            icon: Icon(Icons.auto_stories, size: 50,),
             label: 'Wiki-plants'),

          NavigationDestination(
            icon: Icon(Icons.home, size: 50,),
             label: 'Home'),

          NavigationDestination(
            icon: Icon(Icons.play_circle, size: 50,),
             label: 'Social Media'),

          NavigationDestination(
            icon: Icon(Icons.account_circle, size: 50,),
             label: 'User Profile')
             
             
             
             ,],),

          body : <Widget> [
            const iaPage(),
            const wikiPage(),
            const wikiPage(),
            const SocialMediaPage(),
            UserProfile(user: FirebaseAuth.instance.currentUser),

          ][setIndex],
      ),);
      }
      }

 