import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Auth/Login.dart';

import '../main.dart';

class DoctorAccount extends StatefulWidget {
  @override
  _DoctorAccountState createState() => _DoctorAccountState();
}

class _DoctorAccountState extends State<DoctorAccount> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final userRef = FirebaseFirestore.instance.collection("doctors");
  CollectionReference documents = FirebaseFirestore.instance.collection('DoctorsReviews');

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
          new IconButton(
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
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(instance.currentUser.email).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading');
            return Container(
              color: Colors.white54,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Card(
                      margin: EdgeInsets.all(25),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 10,
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Stack(
                              alignment: Alignment.bottomLeft,
                              children: [
                                Column(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(snapshot.data['imageurl']),
                                      radius: 70.0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data['name'],
                                        style: TextStyle(
                                          color: MainColor,
                                          fontSize: 25,
                                        )),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        for(int i=0;i<snapshot.data['rate'];i++)
                                          Icon(Icons.star,
                                              color: Colors.amberAccent, size: 25.0),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 50, top: 20, right: 50, bottom: 30),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.local_hospital,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['Specialization'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
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
                                        Icons.location_on_outlined,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['address'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
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
                                        Icons.email,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['email'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
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
                                        Icons.phone_android,
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        snapshot.data['phone'],
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
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
                                        color: MainColor,
                                        size: 25,
                                      ),
                                      Text(
                                        "Fees "+snapshot.data['Fees']+" LE",
                                        style: TextStyle(
                                            color: Colors.black38,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 3,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      child: Column(
                        children: [
                          Container(
                            width: 250,
                            height: 3,
                            color: MainColor,
                            margin: EdgeInsets.only(bottom: 30),
                          ),
                        ],
                      ),
                    ),
                    Card(
                      margin: EdgeInsets.all(25),
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () {},
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.star_half,
                                    color: MainColor,
                                    size: 30,
                                  ),

                                  SizedBox(
                                    width: 5,
                                  ),

                                  Text(
                                    "Reviews",
                                    style: TextStyle(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 200, // card height
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: FirebaseFirestore.instance.collection('DoctorsReviews').where('doctorId',isEqualTo: instance.currentUser.email).snapshots(),
                                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                                    if (snapshot.hasError) {
                                      return Text('Something went wrong');
                                    }

                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                      return Text("Loading");
                                    }
                                    if(snapshot.data.docs.isNotEmpty){
                                      return PageView.builder(
                                        itemCount: snapshot.data.size,
                                        controller: PageController(viewportFraction: 0.9),
                                        itemBuilder: (_, i) {
                                          return Transform.scale(
                                            scale: 0.98,
                                            child: Card(
                                              elevation: 16,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(12)),
                                              child: Center(
                                                child: InkWell(
                                                  onTap: () {},
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Stack(
                                                        alignment: Alignment.bottomLeft,
                                                        children: [
                                                          Container(
                                                            padding: const EdgeInsets.only(
                                                                left: 25,
                                                                top: 5,
                                                                right: 30,
                                                                bottom: 2),

                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment
                                                                  .start,
                                                              children: [
                                                                for(int j=0;j<snapshot.data.docs[i]['rate'];j++)
                                                                  Icon(Icons.star,
                                                                      color: Colors.amberAccent,
                                                                      size: 25.0),
                                                              ],
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.only(
                                                            left: 30,
                                                            top: 10,
                                                            right: 30,
                                                            bottom: 10),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              snapshot.data.docs[i]['comment'],
                                                              style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontWeight: FontWeight.bold,
                                                                  fontSize: 25),
                                                            ),
                                                            SizedBox(height: 20,),
                                                            Text(
                                                              snapshot.data.docs[i]['date'],
                                                              style: TextStyle(
                                                                  color: Colors.black38,
                                                                  fontSize: 18),
                                                            ),

                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                // child: Text(
                                                //   "Card ${i + 1}",
                                                //   style: TextStyle(fontSize: 32),
                                                // ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    }
                                    else{
                                      return Card(
                                        elevation: 10,
                                        child: Container(
                                          margin: EdgeInsets.only(top: 100),
                                          padding: EdgeInsets.symmetric(horizontal: 80),
                                          child: Text("No Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        ),
                                      );
                                    }
                                  }
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
