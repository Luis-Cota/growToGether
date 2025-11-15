import 'package:flutter/material.dart';

void main() {
  runApp(const iaPage());
}

class iaPage extends StatelessWidget {
  const iaPage({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ia Camera',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
    );
  }
}