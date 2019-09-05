import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'sign_in.dart';

class GoogleSignInButton extends StatefulWidget {
  final String buttonImage;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  GoogleSignInButton({
    @required this.buttonImage,
    @required this.buttonText,
    @required this.buttonColor,
    @required this.textColor,
  });

  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  String _signingIn = 'idle';

  Widget _signInButton() {
    switch (_signingIn) {
      case 'idle':
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Image(
                image: AssetImage("assets/images/${widget.buttonImage}"),
                height: 30.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                widget.buttonText,
                style: TextStyle(
                  color: widget.textColor,
                  fontSize: 15,
                ),
              ),
            )
          ],
        );
        break;
      case 'working':
        return CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
        );
      case 'done':
        return Icon(
          Icons.done,
          size: 30,
          color: Colors.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      child: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        color: widget.buttonColor,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
            child: _signInButton(),
            // CircularProgressIndicator(
            //   valueColor: new AlwaysStoppedAnimation<Color>(Colors.grey),
            // )
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            //   children: <Widget>[
            //     Image(
            //         image: AssetImage("assets/images/${widget.buttonImage}"),
            //         height: 30.0),
            //     Padding(
            //       padding: const EdgeInsets.only(left: 10),
            //       child: Text(
            //         widget.buttonText,
            //         style: TextStyle(
            //           color: widget.textColor,
            //           fontSize: 15,
            //         ),
            //       ),
            //     )
            //   ],
            // ),
          ),
        ),
        onPressed: () {
          setState(() {
            _signingIn = 'working';
          });
          signInWithGoogle().whenComplete(
            () {
              setState(() {
                _signingIn = 'done';
              });
              Future.delayed(
                const Duration(milliseconds: 800),
                () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return DashboardScreen();
                    },
                  ),
                ),
              );
            },
          ).catchError(
            (e) => SnackBar(
              content: Text('Error Signing In, try again !'),
              backgroundColor: Colors.grey,
              duration: Duration(seconds: 20),
            ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) {
          //       return DashboardScreen();
          //     },
          //   ),
          // );
        },
      ),
    );
  }
}
