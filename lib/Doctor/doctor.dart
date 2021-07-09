import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/MemberHome.dart';

import '../main.dart';
import 'doctor_profile.dart';

class Doctor extends StatefulWidget {
  @override
  _DoctorState createState() => _DoctorState();
}

String dropdownValue = 'All Doctors';

class _DoctorState extends State<Doctor> {
  String name = "null";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text(
          "Doctors",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          IconButton(
              icon: new Icon(
                Icons.home,
                size: 30.0,
              ),
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MemberHome()));
              }),
          IconButton(
              icon: new Icon(
                Icons.logout,
                size: 30.0,
              ),
              onPressed: () {
                instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => Login()));
              }),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Container(
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: MainColor, style: BorderStyle.solid, width: 3),
                      borderRadius:
                          BorderRadius.all(Radius.elliptical(20, 20))),
                  margin: EdgeInsets.all(15),
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: dropdownValue,
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: MainColor,
                      size: 30,
                    ),
                    iconSize: 24,
                    elevation: 16,
                    style: new TextStyle(
                        inherit: false,
                        color: MainColor,
                        decorationColor: Colors.white,
                        fontSize: 20),
                    underline: Container(
                      height: 0,
                      color: MainColor,
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue;
                      });
                    },
                    items: <String>[
                      'All Doctors',
                      'Eyes',
                      'Children',
                      'Chest',
                      'Stomach'
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )),
              SizedBox(height: 15),
              Container(
                child: (dropdownValue == 'All Doctors')
                    ? Container(
                        height: 400,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users').where('rule',isEqualTo: 'doctor')
                                .limit(4)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.data.docs.isNotEmpty) {
                                return new ListView(
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    return Container(
                                      child: Card(
                                        margin: EdgeInsets.all(20),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Container(
                                              margin:EdgeInsets.only(left: 40),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: NetworkImage("${document['imageurl']}"),
                                                    radius: 30.0,
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Text(
                                                      "Dr ${document['name']}",
                                                      style: TextStyle(
                                                        color: Colors
                                                            .blueAccent,
                                                        fontSize: 25,
                                                      )),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50,
                                                  top: 20,
                                                  right: 50,
                                                  bottom: 30),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.email,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['email']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['phone']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.local_hospital,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "Specialized in ${document['Specialization']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['address']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.monetization_on_sharp,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['Fees']} LE",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                      child: Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                        children: [
                                                          for(int i=0;i<document['rate'];i++)
                                                            Icon(Icons.star,
                                                                color: Colors
                                                                    .amberAccent,
                                                                size: 25.0),
                                                        ],
                                                      )
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          margin:
                                                          EdgeInsets.only(
                                                              top: 20),
                                                          child: RaisedButton(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    20)),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                                vertical:
                                                                15,
                                                                horizontal:
                                                                25),
                                                            color: MainColor,
                                                            child: Text(
                                                              'View Doctor Profile',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                  20),
                                                            ),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder:
                                                                          (context) =>
                                                                          DoctorProfile(document.id)));
                                                            },
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Container(
                                  margin: EdgeInsets.only(top: 100),
                                  child: Text(
                                    "No Doctors",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }
                            }),
                      )
                    : Container(
                        height: 400,
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('users').where('rule',isEqualTo: 'doctor')
                                .where('Specialization', isEqualTo: dropdownValue)
                                .snapshots(),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Text("Loading");
                              }
                              if (snapshot.data.docs.isNotEmpty) {
                                return new ListView(
                                  children: snapshot.data.docs
                                      .map((DocumentSnapshot document) {
                                    return Container(
                                      child: Card(
                                        margin: EdgeInsets.all(10),
                                        clipBehavior: Clip.antiAlias,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Stack(
                                              alignment: Alignment.bottomLeft,
                                              children: [
                                                Container(
                                                  margin:EdgeInsets.only(left: 40),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage: NetworkImage("${document['imageurl']}"),
                                                        radius: 30.0,
                                                      ),
                                                      SizedBox(
                                                        width: 20,
                                                      ),
                                                      Text(
                                                          "Dr ${document['name']}",
                                                          style: TextStyle(
                                                            color: Colors
                                                                .blueAccent,
                                                            fontSize: 25,
                                                          )),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 50,
                                                  top: 20,
                                                  right: 50,
                                                  bottom: 30),
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.email,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['email']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.phone,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['phone']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.local_hospital,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "Specialized in ${document['Specialization']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons
                                                            .location_on_outlined,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['address']}",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.money,
                                                        color:
                                                        Colors.blueAccent,
                                                        size: 25,
                                                      ),
                                                      Text(
                                                        "${document['Fees']} LE",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .black38,
                                                            fontWeight:
                                                            FontWeight
                                                                .bold,
                                                            fontSize: 18),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 7,
                                                  ),
                                                  Container(
                                                    child: Row(
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      children: [
                                                        for(int i=0;i<document['rate'];i++)
                                                        Icon(Icons.star,
                                                            color: Colors
                                                                .amberAccent,
                                                            size: 25.0),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 3,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          margin:
                                                          EdgeInsets.only(
                                                              top: 20),
                                                          child: RaisedButton(
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      20)),
                                                              padding: EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                  15,
                                                                  horizontal:
                                                                  25),
                                                              color:
                                                              MainColor,
                                                              child: Text(
                                                                'View Doctor Profile',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontSize:
                                                                    20),
                                                              ),
                                                              onPressed:
                                                                  () {
                                                                    Navigator.push(
                                                                        context, MaterialPageRoute(builder: (context) => DoctorProfile(document.id)));
                                                                  })),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                );
                              } else {
                                return Container(
                                  margin: EdgeInsets.only(top: 100),
                                  child: Text(
                                    "No Doctors",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                );
                              }
                            }),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
