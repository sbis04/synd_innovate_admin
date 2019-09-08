import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'login_screen.dart';
import 'profile_info_row.dart';
import 'sign_in.dart';

class ProfileScreen extends StatefulWidget {
  final String userImageUrl;
  final String userName;
  final String gender;
  final String address;
  final String levelString;
  final int level;
  final int leads;
  final int rewardPoints;

  ProfileScreen({
    this.userImageUrl,
    this.userName,
    this.gender,
    this.address,
    this.levelString,
    this.level,
    this.leads,
    this.rewardPoints,
  });

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future getUserData() async {
    DocumentSnapshot userData =
        await documentReference.collection('user_data').document(uid).get();

    return userData;
  }

  @override
  Widget build(BuildContext context) {
    String levelAsset = '';

    switch (widget.level) {
      case 0:
        levelAsset = '';
        break;

      case 1:
        levelAsset = 'level_1.svg';
        break;

      default:
        levelAsset = 'top_level.svg';
    }

    return Scaffold(
      body: Stack(
        fit: StackFit.loose,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xFFFFCD00),
            ),
          ),
          Container(
            width: 140,
            decoration: BoxDecoration(
              color: Color(0xFFFF9D00),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      margin: EdgeInsets.all(0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.elliptical(250, 170),
                          bottomRight: Radius.elliptical(250, 170),
                        ),
                      ),
                      elevation: 10,
                      color: Color(0xFFF6711D),
                      child: SafeArea(
                        child: Column(
                          children: <Widget>[
                            Row(),
                            SizedBox(height: 20),
                            Stack(
                              children: <Widget>[
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                  child: Icon(Icons.account_circle, size: 50),
                                ),
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    widget.userImageUrl,
                                  ),
                                  radius: 50,
                                  backgroundColor: Colors.transparent,
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Text(
                              '${widget.leads} Leads',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 10),
                            Text(
                              '${widget.rewardPoints} Reward points',
                              style: TextStyle(fontSize: 20),
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Transfer to bank',
                              style: TextStyle(
                                  fontSize: 15, color: Color(0xFF228164)),
                            ),
                            SizedBox(height: 30),
                            Text(
                              widget.levelString,
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Color(0xCC3100FF),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            levelAsset != ''
                                ? SvgPicture.asset(
                                    'assets/images/level_1.svg',
                                    color: Color(0xFF3100FF),
                                  )
                                : Text(''),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 30,
                    right: 10,
                  ),
                  child: Column(
                    children: <Widget>[
                      widget.leads >= 100
                          ? ProfileInfoRow(
                              rowKey: 'Name: ',
                              rowValue: widget.userName,
                              assetName: 'check_mark.svg',
                            )
                          : ProfileInfoRow(
                              rowKey: 'Name: ',
                              rowValue: widget.userName,
                            ),
                      SizedBox(height: 30),
                      ProfileInfoRow(
                        rowKey: 'Gender: ',
                        rowValue: widget.gender,
                      ),
                      SizedBox(height: 30),
                      ProfileInfoRow(
                        rowKey: 'Address: ',
                        rowValue: widget.address,
                      ),
                      SizedBox(height: 30),
                    ],
                  ),
                )
              ],
            ),
          ),
          // FutureBuilder(
          //   future: getUserData(),
          //   builder: (_, snapshot) {
          //     if (snapshot.connectionState == ConnectionState.waiting ||
          //         !snapshot.hasData) {
          //       return Container(
          //         child: Center(
          //           child: CircularProgressIndicator(),
          //         ),
          //       );
          //     } else {
          //       int numberOfLeads = snapshot.data['leads'];
          //       int level = snapshot.data['level'];
          //       int rewardPoints = snapshot.data['reward_points'];
          //       String gender = snapshot.data['gender'];
          //       String address = snapshot.data['address'];
          //       String name = snapshot.data['name'];

          //       return SingleChildScrollView(
          //         child: Column(
          //           children: <Widget>[
          //             Container(
          //               child: Align(
          //                 alignment: Alignment.topCenter,
          //                 child: Card(
          //                   margin: EdgeInsets.all(0),
          //                   shape: RoundedRectangleBorder(
          //                     borderRadius: BorderRadius.only(
          //                       bottomLeft: Radius.elliptical(250, 170),
          //                       bottomRight: Radius.elliptical(250, 170),
          //                     ),
          //                   ),
          //                   elevation: 10,
          //                   color: Color(0xFFF6711D),
          //                   child: SafeArea(
          //                     child: Column(
          //                       children: <Widget>[
          //                         Row(),
          //                         SizedBox(height: 20),
          //                         Stack(
          //                           children: <Widget>[
          //                             CircleAvatar(
          //                               radius: 50,
          //                               backgroundColor: Colors.transparent,
          //                               child: Icon(Icons.account_circle,
          //                                   size: 50),
          //                             ),
          //                             CircleAvatar(
          //                               backgroundImage: NetworkImage(
          //                                 imageUrl,
          //                               ),
          //                               radius: 50,
          //                               backgroundColor: Colors.transparent,
          //                             ),
          //                           ],
          //                         ),
          //                         SizedBox(height: 20),
          //                         Text(
          //                           '$numberOfLeads Leads',
          //                           style: TextStyle(
          //                             fontSize: 25,
          //                             fontWeight: FontWeight.bold,
          //                           ),
          //                         ),
          //                         SizedBox(height: 10),
          //                         Text(
          //                           '$rewardPoints Reward points',
          //                           style: TextStyle(fontSize: 20),
          //                         ),
          //                         SizedBox(height: 5),
          //                         Text(
          //                           'Transfer to bank',
          //                           style: TextStyle(
          //                               fontSize: 15, color: Color(0xFF228164)),
          //                         ),
          //                         SizedBox(height: 30),
          //                         Text(
          //                           'Level $level Partner',
          //                           style: TextStyle(
          //                               fontSize: 20,
          //                               color: Color(0xCC3100FF),
          //                               fontWeight: FontWeight.bold),
          //                         ),
          //                         SizedBox(height: 10),
          //                         SvgPicture.asset(
          //                           'assets/images/level_1.svg',
          //                           color: Color(0xFF3100FF),
          //                         ),
          //                         SizedBox(height: 30),
          //                       ],
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             SizedBox(height: 50),
          //             Padding(
          //               padding: const EdgeInsets.only(
          //                 left: 30,
          //                 right: 10,
          //               ),
          //               child: Column(
          //                 children: <Widget>[
          //                   numberOfLeads >= 100
          //                       ? ProfileInfoRow(
          //                           rowKey: 'Name: ',
          //                           rowValue: name,
          //                           assetName: 'check_mark.svg',
          //                         )
          //                       : ProfileInfoRow(
          //                           rowKey: 'Name: ',
          //                           rowValue: name,
          //                         ),
          //                   SizedBox(height: 30),
          //                   ProfileInfoRow(
          //                     rowKey: 'Gender: ',
          //                     rowValue: gender,
          //                   ),
          //                   SizedBox(height: 30),
          //                   ProfileInfoRow(
          //                     rowKey: 'Address: ',
          //                     rowValue: address,
          //                   ),
          //                   SizedBox(height: 30),
          //                 ],
          //               ),
          //             )
          //           ],
          //         ),
          //       );
          //     }
          //   },
          // ),
          SafeArea(
            child: InkWell(
              splashColor: Colors.black,
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 15,
                  top: 10,
                ),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 30,
                ),
              ),
            ),
          ),
          // SafeArea(
          //   child: Align(
          //     alignment: Alignment.topRight,
          //     child: Padding(
          //       padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
          //       child: RaisedButton(
          //         elevation: 8,
          //         color: Colors.blue[600],
          //         shape: RoundedRectangleBorder(
          //             borderRadius: BorderRadius.circular(20)),
          //         child: Text(
          //           "SIGN OUT",
          //           style: TextStyle(
          //             color: Colors.white,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         onPressed: () {
          //           signOutGoogle();
          //           Navigator.of(context).pushAndRemoveUntil(
          //             MaterialPageRoute(
          //               builder: (context) => LoginScreen(),
          //             ),
          //             ModalRoute.withName('/'),
          //           );
          //         },
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
