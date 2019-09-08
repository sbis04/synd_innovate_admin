import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'login_screen.dart';
import 'profile_screen.dart';
import 'sign_in.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;
  FocusNode _productFocusNode = FocusNode();
  FocusNode _rewardFocusNode = FocusNode();

  String newProduct;
  String newRewardPoint;

  int currentPage = 0;
  Future getProducts() async {
    QuerySnapshot productQuery =
        await documentReference.collection('products').getDocuments();

    return productQuery.documents;
  }

  Future getUserData() async {
    QuerySnapshot usersData =
        await documentReference.collection('user_data').getDocuments();

    return usersData.documents;
  }

  void _addProduct() async {
    DocumentReference documentReferencer =
        documentReference.collection('products').document();

    Map<String, dynamic> data = <String, dynamic>{
      "name": newProduct,
      "reward_points": int.tryParse(newRewardPoint),
    };

    await documentReferencer.setData(data).whenComplete(() {
      print("product added");
    }).catchError((e) => print(e));
  }

  String validateProduct(String value) {
    if (value.length == 0)
      return 'Product name cannot be empty';
    else
      return null;
  }

  void _validateInputs() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
    } else {
      _autoValidate = true;
    }
  }

  String validateRewardPoints(String value) {
    if (value.length == 0)
      return 'Reward points cannot be empty';
    else
      return null;
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      Stack(
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
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xCCEFC622),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 0),
              child: Container(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'New Product Details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50),
                    Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              cursorColor: Colors.black,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              focusNode: _productFocusNode,
                              textCapitalization: TextCapitalization.words,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Colors.black)),
                                  hintText: 'Enter product name',
                                  labelText: 'Product',
                                  focusColor: Colors.black,
                                  fillColor: Colors.black,
                                  hoverColor: Colors.black),
                              validator: validateProduct,
                              textInputAction: TextInputAction.done,
                              onSaved: (val) {
                                newProduct = val;
                                _productFocusNode.nextFocus();
                              },
                            ),
                          ),
                          SizedBox(height: 40),
                          Container(
                            constraints:
                                BoxConstraints.loose(Size.fromHeight(300.0)),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              cursorColor: Colors.black,
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                              focusNode: _rewardFocusNode,
                              decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black),
                                  ),
                                  hintText: 'Enter reward points',
                                  labelText: 'Reward Points',
                                  focusColor: Colors.black,
                                  fillColor: Colors.black,
                                  hoverColor: Colors.black),
                              textInputAction: TextInputAction.done,
                              validator: validateRewardPoints,
                              onSaved: (val) {
                                newRewardPoint = val;
                                _rewardFocusNode.unfocus();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Center(
                          child: FlatButton(
                            color: Color(0xFFF6711D),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                                top: 10,
                                bottom: 10,
                              ),
                              child: Text(
                                'SAVE',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            onPressed: () {
                              _validateInputs();
                              if (newProduct != null &&
                                  newRewardPoint != null) {
                                _addProduct();
                                setState(() {
                                  newProduct = null;
                                  newRewardPoint = null;
                                });
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => DashboardScreen(),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              color: Color(0xCCEFC622),
            ),
          ),
          SafeArea(
            child: FutureBuilder(
              future: getUserData(),
              builder: (_, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: ListView.builder(
                      itemCount: snapshot.data.length,
                      itemBuilder: (_, index) {
                        String userName = snapshot.data[index].data['name'];
                        print(userName);
                        int level = snapshot.data[index].data['level'];
                        int leads = snapshot.data[index].data['leads'];
                        String userImageUrl =
                            snapshot.data[index].data['image_url'];
                        String gender = snapshot.data[index].data['gender'];
                        String address = snapshot.data[index].data['address'];
                        int rewardPoints =
                            snapshot.data[index].data['reward_points'];
                        String partnerLevel;

                        String levelAsset;

                        switch (level) {
                          case 0:
                            partnerLevel = 'No Level';
                            levelAsset = '';
                            break;

                          case 1:
                            partnerLevel = 'Level 1 Partner';
                            levelAsset = 'medal_1.png';
                            break;

                          case 2:
                            partnerLevel = 'Level 2 Partner';
                            levelAsset = 'medal_2.png';
                            break;

                          default:
                            partnerLevel = 'Top Level Parther';
                            levelAsset = 'medal_3.png';
                        }

                        return Padding(
                          padding: const EdgeInsets.fromLTRB(15, 25, 15, 0),
                          child: InkWell(
                            child: Card(
                              elevation: 8,
                              color: Color(0xFFFFCD00),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        children: <Widget>[
                                          Text(
                                            userName,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            partnerLevel,
                                            style: TextStyle(
                                              color: Color(0xFF3100FF),
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 5),
                                          Text(
                                            leads.toString() + ' Leads',
                                            style: TextStyle(
                                              color: Color(0xFF006CFF),
                                              fontSize: 18,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: levelAsset != ''
                                          ? Image.asset(
                                              'assets/images/$levelAsset',
                                              color: Color(0xFF3100FF),
                                              height: 120,
                                            )
                                          : Text(''),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => ProfileScreen(
                                    userImageUrl: userImageUrl,
                                    userName: userName,
                                    gender: gender,
                                    address: address,
                                    level: level,
                                    leads: leads,
                                    levelString: partnerLevel,
                                    rewardPoints: rewardPoints,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 5, 5, 0),
                child: RaisedButton(
                  elevation: 8,
                  color: Colors.blue[600],
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    signOutGoogle();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      ModalRoute.withName('/'),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      )
    ];

    return Scaffold(
      bottomNavigationBar: FancyBottomNavigation(
        barBackgroundColor: Color(0xFFF6711D),
        inactiveIconColor: Colors.black54,
        activeIconColor: Colors.black,
        textColor: Colors.white,
        circleColor: Color(0xFFFFCD00),
        initialSelection: currentPage,
        tabs: [
          TabData(
            iconData: Icons.dashboard,
            title: "Dashboard",
          ),
          TabData(
            iconData: Icons.add_circle,
            title: "Add",
          ),
          TabData(
            iconData: Icons.account_circle,
            title: "Profiles",
          ),
        ],
        onTabChangedListener: (position) {
          setState(() {
            currentPage = position;
          });
        },
      ),
      body: _widgetOptions[currentPage],
    );
  }
}
