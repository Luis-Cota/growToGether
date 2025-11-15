import 'package:flutter/material.dart';

void main() {
  runApp(const wikiPage());
}

class wikiPage extends StatelessWidget {
  const wikiPage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GrowTogether prototype',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
    );
  }
}