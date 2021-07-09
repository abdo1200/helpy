import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Doctor/doctor_profile.dart';
import 'package:helpy/main.dart';

import 'messagesBubble.dart';

class Messages extends StatefulWidget {
  String iD;
  Messages(this.iD);
  @override
  _MessagesState createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream : FirebaseFirestore.instance.collection('chat').doc(instance.currentUser.email).collection('messages').doc(widget.iD).collection('docmess').orderBy('createdAt' , descending: true).snapshots(),
      builder: (ctx , snapshots) {
        if (snapshots.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final docs = snapshots.data.docs;
        final user = FirebaseAuth.instance.currentUser;
        // print(docs[0]['text']);
        if(docs ==null){
          return Text('no message');
        }
        else {
          return ListView.builder(
              reverse: true,
              itemCount: docs.length,
              itemBuilder: (ctx, index) {
          return Container(
            child: (instance.currentUser.email==docs[index]['sender'])?Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 10,top:10),
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                  decoration: BoxDecoration(
                    color: MainColor,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Text(docs[index]['text'],style: TextStyle(color: Colors.white,fontSize: 20),)
                ),
              ],
            ):Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                    margin: EdgeInsets.only(right: 10,top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 5),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Text(docs[index]['text'],style: TextStyle(color: MainColor,fontSize: 20),)
                ),
              ],
            ),
          );
        }
          );
        }
      }

    );
  }
}
