import 'package:flutter/material.dart';
import 'dart:async';

import 'login_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 3),
      () => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) {
            return LoginScreen();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xffFFCD00),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
              left: 15,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Image.asset('assets/images/logo.png'),
                    SizedBox(height: 30),
                    Text(
                      'ADMIN',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Color(0xFFF6711D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
