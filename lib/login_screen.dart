import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

import 'facebook_button.dart';
import 'google_button.dart';
import 'linkedIn_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Color(0xffFFCD00),
          ),
        ),
        SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 15,
                  right: 15,
                  left: 15,
                ),
                child: Image.asset('assets/images/logo.png'),
              ),
              Card(
                elevation: 8,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                color: Colors.white70,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(30, 30, 30, 20),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'Admin Login',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 25),
                      GoogleSignInButton(
                        buttonImage: 'google_logo.png',
                        buttonText: 'Sign in with Google',
                        buttonColor: Colors.white,
                        textColor: Colors.grey,
                      ),
                      SizedBox(height: 25),
                      FacebookSignInButton(
                        buttonImage: 'face_logo.png',
                        buttonText: 'Login in with Facebook',
                        buttonColor: Color(0xff3A559F),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 25),
                      LinkedInSignInButton(
                        buttonImage: 'linkedin_logo.png',
                        buttonText: 'Sign in with LinkedIn',
                        buttonColor: Color(0xff007AB9),
                        textColor: Colors.white,
                      ),
                      SizedBox(height: 25),
                      FlatButton(
                        child: Text('Sign in using OTP'),
                        onPressed: () {
                          return Flushbar(
                            message: 'Not yet implemented',
                            icon: Icon(
                              Icons.info_outline,
                              size: 28,
                              color: Colors.blue[200],
                            ),
                            leftBarIndicatorColor: Colors.blue,
                            duration: Duration(seconds: 3),
                          )..show(context);
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
