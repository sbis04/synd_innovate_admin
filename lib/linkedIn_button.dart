import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

class LinkedInSignInButton extends StatefulWidget {
  final String buttonImage;
  final String buttonText;
  final Color buttonColor;
  final Color textColor;

  LinkedInSignInButton({
    @required this.buttonImage,
    @required this.buttonText,
    @required this.buttonColor,
    @required this.textColor,
  });

  @override
  _LinkedInSignInButtonState createState() => _LinkedInSignInButtonState();
}

class _LinkedInSignInButtonState extends State<LinkedInSignInButton> {
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
            child: Row(
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
            ),
          ),
        ),
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
      ),
    );
  }
}
