import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/AdminHome.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/SizeConfig.dart';

import 'DoctorHome.dart';
import 'MemberHome.dart';

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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Login()));
      } else {
        FirebaseFirestore.instance.collection('users').doc(instance.currentUser.email).get().then((value){
          if(instance.currentUser.email=='admin@admin.com'){
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => AdminHome()));
          }else{
            if(value['rule']=='member'){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MemberHome()));
            }else if(value['rule']=='doctor'){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DoctorHome()));
            }
          }
        });
      }
    });

  }
  Widget build(BuildContext context) {
    return Login();
  }
}
