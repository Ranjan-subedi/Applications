import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    splash();
  }

  splash() async {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white70,
      body: Center(
        child: AnimatedTextKit(
          repeatForever: true,
          pause: Duration(microseconds: 0),

          animatedTexts: [
            ColorizeAnimatedText(
              'Gallery',
              textStyle: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              colors: [Colors.red, Colors.green, Colors.blue,Colors.white],
            ),
          ],
        ),
      ),
    );
  }
}
