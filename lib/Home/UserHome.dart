import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Home/DoctorHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'MemberHome.dart';

class UserHome extends StatefulWidget {
  String rule;
  UserHome(this.rule);
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  FirebaseAuth instance = FirebaseAuth.instance;
  String rule;
  final spinkit = SpinKitFadingCircle(
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Colors.red : Colors.green,
        ),
      );
    },
  );
  @override
  Widget build(BuildContext context)  {
    return Container();
  }
}

