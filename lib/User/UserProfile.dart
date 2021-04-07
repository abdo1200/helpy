// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class UserProfile extends StatefulWidget {
//   @override
//   _UserProfileState createState() => _UserProfileState();
// }
//
// class _UserProfileState extends State<UserProfile> {
//   CollectionReference users = FirebaseFirestore.instance.collection('users');
//   FirebaseAuth instance = FirebaseAuth.instance;
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Container(
//           width: double.infinity,
//           child: Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text("hello this is user profile"),
//                 Container(
//                   height: 300,
//                   child: StreamBuilder(
//                       stream: FirebaseFirestore.instance
//                           .collection('users')
//                           .doc(instance.currentUser.email) //ID OF DOCUMENT
//                           .snapshots(),
//                       builder: (context, snapshot) {
//                         if (!snapshot.hasData) {
//                           return new Text("Loading");
//                         }
//                         var userDocument = snapshot.data;
//                         return new Text(userDocument["name"]);
//                       }
//                   )
//                   // How to Retrive All Document
//                   //----------------------------------------------------
//                   // StreamBuilder<QuerySnapshot>(
//                   //   stream: users.snapshots(),
//                   //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                   //     if (snapshot.hasError) {
//                   //       return Text('Something went wrong');
//                   //     }
//                   //
//                   //     if (snapshot.connectionState == ConnectionState.waiting) {
//                   //       return Text("Loading");
//                   //     }
//                   //
//                   //     return new ListView(
//                   //       children: snapshot.data.docs.map((DocumentSnapshot document) {
//                   //         return new ListTile(
//                   //           title: new Text(document.data()['name']),
//                   //           subtitle: new Text(document.data()['email']),
//                   //         );
//                   //       }).toList(),
//                   //     );
//                   //   },
//                   // ),
//                 ),
//                 RaisedButton(
//                   child: Text("Tap me"),
//                   onPressed: (){
//                     print(users.doc(instance.currentUser.email).get());
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
