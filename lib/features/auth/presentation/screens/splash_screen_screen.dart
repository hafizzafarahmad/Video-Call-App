import 'package:flutter/material.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenScreen createState() => _SplashScreenScreen();
}

class _SplashScreenScreen extends State<SplashScreenScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(color: Colors.white),
          ),
          Center(
            child:  Image.asset(
              'assets/video-camera.png',
              fit: BoxFit.cover,
              width: 150,
            ),
          )
        ],
      ),
    );
  }

}

