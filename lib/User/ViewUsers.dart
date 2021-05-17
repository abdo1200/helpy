import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Admin/delete_user.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Reviews/Reviews.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color w = Colors.white;
Color b = Colors.black;

class ViewUsers extends StatelessWidget {
  FirebaseAuth instance = FirebaseAuth.instance;

  final List<Reviews> Rev = [
    Reviews(name: "Radwa", Reviewws: "Wow"),
    Reviews(name: "Radwaa", Reviewws: "Woow"),
    Reviews(name: "Radwaaa", Reviewws: "Wooow"),
    Reviews(name: "Radwaaaaa", Reviewws: "Wooooow"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Users'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            ...Rev.map((e) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.only(top: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10,bottom: 10,right: 20),
                            width: 50.0,
                            height: 50.0,
                            decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  fit: BoxFit.fill,
                                  image: AssetImage(
                                    "assets/img/hospitals/cleopatra.jpg",
                                  ),
                                ))),
                        Text(
                          e.name,
                          style: TextStyle(
                              color: Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Container(
                      margin:EdgeInsets.only(right: 20),
                      child: RaisedButton(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        color: MainColor,
                        child: Text("View",style: TextStyle(fontSize: 17),),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DeleteUser()));
                        },
                        shape: new RoundedRectangleBorder(
                            borderRadius:
                            new BorderRadius.circular(30.0)),
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
