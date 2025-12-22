import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/pages/game_page.dart';

class Splashpage extends StatefulWidget {
  const Splashpage({super.key});

  @override
  State<Splashpage> createState() => _SplashpageState();
}

class _SplashpageState extends State<Splashpage> {

splashfunction()async {
  // Text('Ranjan\'s Game')
  await Future.delayed(Duration(seconds: 3));

  Navigator.pushReplacement(context, MaterialPageRoute(
    builder: (context) => Tic_Tac_Toe(),
  ));
  }

  @override
  void initState() {
    // TODO: implement initState
    splashfunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(height: 140,),
          Center(
            child: AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
              WavyAnimatedText(
                  'Tic-Tac-Toe',textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    shadows: [
                      Shadow(
                        color: Color(0xFF00FFA3),
                        blurRadius: 9,
                      )
                    ]
                  )),
            ]),
          ),

          Text("\@ copyright clam to Ranjan Subedi"),
        ],
      ),
    );
  }
}
