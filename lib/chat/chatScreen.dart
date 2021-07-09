 import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Doctor/doctor_profile.dart';
import 'package:helpy/chat/messages.dart';
import 'package:helpy/chat/newMesaage.dart';

class ChatScreen extends StatefulWidget {
  String iD;
  String name;
  ChatScreen(this.iD,this.name);
  _ChatScreenState createState() => _ChatScreenState();
}
  class _ChatScreenState extends State<ChatScreen>{


    @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Color(0xffece5dd),
        appBar: AppBar(
          title: Text(widget.name),
          actions: [
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
        body:
        Container(
          child: Column(
            children: [
              Expanded(
                child: Messages(widget.iD),
              ),
              NewMessages(widget.iD),
            ],
          ),
        ),
      );
    }

  }
