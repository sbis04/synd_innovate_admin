import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileInfoRow extends StatelessWidget {
  final String rowKey;
  final String rowValue;
  final String assetName;

  ProfileInfoRow({
    @required this.rowKey,
    @required this.rowValue,
    this.assetName,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Text(
            rowKey,
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Colors.black54),
          ),
        ),
        Expanded(
          flex: 2,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: assetName != null
                ? Row(
                    children: <Widget>[
                      Text(
                        rowValue,
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      SizedBox(width: 5),
                      SvgPicture.asset(
                        'assets/images/$assetName',
                        color: Color(0xFF168B2D),
                      ),
                    ],
                  )
                : Text(
                    rowValue,
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
          ),
        ),
        SvgPicture.asset(
          'assets/images/edit_outline.svg',
        ),
      ],
    );
  }
}
