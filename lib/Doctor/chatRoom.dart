import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'file:///C:/Users/abdos/AndroidStudioProjects/helpy/lib/chat/chatScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../main.dart';

class ChatRoom extends StatelessWidget {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text(
          "Chats",
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
      body: StreamBuilder<QuerySnapshot>(
          stream : FirebaseFirestore.instance.collection('UsersChat').doc(instance.currentUser.email).collection('Room').snapshots(),
          builder: (ctx , snapshots) {
            if (snapshots.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final docs = snapshots.data.docs;
            final user = FirebaseAuth.instance.currentUser;

            if(docs ==null){
              return Text('no message');
            }
            else {
              return ListView.builder(
                  itemCount: docs.length,
                  itemBuilder: (ctx, index) {
                    return StreamBuilder(
                      stream: FirebaseFirestore.instance.collection('users').doc(docs[index]['Email']).snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const Text('loading');
                        return Container(
                          margin: EdgeInsets.only(top: 10),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          color: Colors.white54,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            elevation: 10,
                            child: Column(
                              children: [
                                SizedBox(
                                  width: 5,
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(width: 10,),
                                        CircleAvatar(
                                          backgroundImage: NetworkImage(snapshot.data['imageurl']),
                                          radius: 35.0,
                                        ),
                                        SizedBox(
                                          width: 9,
                                          height: 10,
                                        ),
                                        Text(
                                          snapshot.data['name'],
                                          style: TextStyle(
                                            color: MainColor,
                                            fontSize: 24,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(right: 10),
                                      decoration: BoxDecoration(
                                        color: MainColor,
                                        borderRadius: BorderRadius.circular(50)
                                      ),
                                      child: IconButton(
                                          icon: new Icon(
                                            Icons.arrow_forward_ios,
                                            color: Colors.white,
                                            size: 20.0,
                                          ),
                                          onPressed: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                                              return ChatScreen(snapshot.data['email'],snapshot.data['name']);
                                            }));
                                            //));
                                          }
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
              );

            }
          }




      )


    );
  }
}
