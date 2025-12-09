import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:const Tic_Tac_Toe(),
    );
  }
}



