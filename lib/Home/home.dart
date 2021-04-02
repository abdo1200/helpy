import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/AdminHome.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    instance.authStateChanges().listen((User) {
      if (User == null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        print('have user');
      }
    });
  }
  Widget build(BuildContext context) {
    if(instance.currentUser.email=='admin@admin.com'){
      return AdminHome();
    }else{
      return UserHome();
    }

  }
}
