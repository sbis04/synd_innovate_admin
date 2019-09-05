import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'profile_screen.dart';
import 'sign_in.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Future getProducts() async {
    QuerySnapshot productQuery =
        await documentReference.collection('products').getDocuments();

    return productQuery.documents;
  }

  Future getUserData() async {
    DocumentSnapshot userData =
        await documentReference.collection('user_data').document(uid).get();

    return userData;
  }

  // void _addUserData() {
  //   DocumentReference documentReferencer =
  //       documentReference.collection('user_data').document(uid);

  //   Map<String, dynamic> data = <String, dynamic>{
  //     "name": name,
  //     "leads": 10,
  //     "reward_points": 4800,
  //     "partner_level": 1,
  //     "green_check": 'true',
  //   };

  //   documentReferencer.setData(data).whenComplete(() {
  //     print("document added");
  //   }).catchError((e) => print(e));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFFFFA700),
        elevation: 5.0,
        // child: Icon(
        //   Icons.account_circle,
        //   color: Colors.black87,
        //   size: 70,
        // ),
        child: Stack(
          children: <Widget>[
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.transparent,
              child: Icon(Icons.account_circle, size: 50),
            ),
            CircleAvatar(
              backgroundImage: NetworkImage(
                imageUrl,
              ),
              radius: 50,
              backgroundColor: Colors.transparent,
            ),
          ],
        ),
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return ProfileScreen();
              },
            ),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      bottomNavigationBar: BottomAppBar(
        color: Color(0xFFF6711D),
        child: new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: FutureBuilder(
                future: getUserData(),
                builder: (_, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text(
                      'Leads',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else if (snapshot.hasData) {
                    int numberOfLeads = snapshot.data['leads'];

                    return Text(
                      numberOfLeads.toString() + ' Leads',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  } else {
                    return Text(
                      'No data',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    );
                  }
                },
              ),
            )
          ],
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xCCEFC622),
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Card(
                    margin: EdgeInsets.all(0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    elevation: 10,
                    color: Color(0xffFFCD00),
                    child: SafeArea(
                      child: CarouselSlider(
                        autoPlay: true,
                        viewportFraction: 1.0,
                        height: 250,
                        items: <Widget>[
                          Image.asset('assets/images/synd_disc.png'),
                          Image.asset('assets/images/synd_disc.png'),
                          Image.asset('assets/images/synd_disc.png'),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: FutureBuilder(
                    future: getProducts(),
                    builder: (_, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else {
                        return GridView.builder(
                          physics: BouncingScrollPhysics(),
                          gridDelegate:
                              new SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount:
                              snapshot.hasData ? snapshot.data.length : 0,
                          itemBuilder: (BuildContext context, int index) {
                            String prodName = snapshot.data[index].data['name'];
                            // int prodRewardPoints =
                            //     snapshot.data[index].data['reward_points'];

                            return Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Card(
                                color: Color(0xCC327E81),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      size: 30,
                                      color: Colors.white60,
                                    ),
                                    SizedBox(height: 10),
                                    Text(
                                      prodName,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
