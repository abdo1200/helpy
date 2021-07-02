import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('email',isEqualTo: instance.currentUser.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            return Column(
              children: [
                Container(
                  // background
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(28, 117, 201, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(60.0),
                        bottomRight: const Radius.circular(60.0)),
                  ),
                  child: Column(
                    children: [
                      // app bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 5),
                            decoration: BoxDecoration(
                                color:MainColor,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,right: 5),
                            decoration: BoxDecoration(
                                color:MainColor,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.exit_to_app),
                              onPressed: (){
                                instance.signOut();
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => Login()));
                              },
                            ),
                          ),

                        ],
                      ),
                      // image
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage(snapshot.data.docs[0].data()['imageurl']),
                          radius: 50.0,
                        ),
                      ),
                      // name
                      Container(
                        margin: EdgeInsets.only(top: 20.0),
                        child: Text(snapshot.data.docs[0].data()['name'],
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold)),
                      ), // user name
                    ],
                  ),
                ),
                //email
                FractionallySizedBox(
                  widthFactor: .95,
                  child: Container(
                    margin: const EdgeInsets.only(top: 25.0),
                    padding: EdgeInsets.all(3.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 25.0,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.email,
                              color: Color.fromRGBO(28, 117, 201, 1),
                              size: 35,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 12.0),
                          child: Text(snapshot.data.docs[0].data()['email'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                // phone and gender
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 20.0, right: 20),
                      padding: EdgeInsets.only(top:2.0,bottom: 2,right: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.phone_android,
                                color: Color.fromRGBO(28, 117, 201, 1),
                                size: 30,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(snapshot.data.docs[0].data()['phone'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20.0),
                      padding: EdgeInsets.all(2.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Row(
                        children: [
                          Container(
                            child: IconButton(
                              icon: Icon(
                                Icons.person,
                                color: Color.fromRGBO(28, 117, 201, 1),
                                size: 35,
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.only(right: 25.0),
                            child: Text(snapshot.data.docs[0].data()['gender'],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                //address
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 35.0, right: 35.0),
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.add_location,
                            color: Color.fromRGBO(28, 117, 201, 1),
                            size: 35,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(snapshot.data.docs[0].data()['address'],
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .55,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(2.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                            left: 20.0,
                          ),
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today,
                              color: Color.fromRGBO(28, 117, 201, 1),
                              size: 30,
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: 10.0),
                          child: Text(snapshot.data.docs[0].data()['birthday'],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: .70,
                        child: Container(
                          margin: EdgeInsets.only(top: 25,bottom: 20),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Color.fromRGBO(28, 117, 201, 1),
                            onPressed: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => EditProfile()));
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('Edit',
                                    style: TextStyle(fontSize: 18, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: .80,
                        child: Container(
                          margin: EdgeInsets.only(top: 25,bottom: 20),
                          child: RaisedButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            color: Colors.red,
                            onPressed: () {
                              User user= instance.currentUser;
                              String email = instance.currentUser.email;
                              user.delete().then((value) => {
                                instance.signOut(),
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => Login())),
                                FirebaseFirestore.instance.collection("users").doc(email).delete(),

                              });
                            },
                            child: Row(
                              children: [
                                IconButton(
                                  icon: Icon(
                                    Icons.delete_forever,
                                    color: Colors.white,
                                  ),
                                ),
                                Text('Delete',
                                    style: TextStyle(fontSize: 18, color: Colors.white)),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
