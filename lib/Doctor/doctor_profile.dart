import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DoctorProfile extends StatefulWidget {
  String id;
  DoctorProfile(this.id);
  @override
_DoctorProfileState createState() => _DoctorProfileState();
  }
FirebaseAuth instance = FirebaseAuth.instance;
final userRef = FirebaseFirestore.instance.collection("doctors");
class _DoctorProfileState extends State<DoctorProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
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
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('users').doc(widget.id).snapshots(),
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
                                      backgroundImage: NetworkImage(snapshot.data['img']),
                                      radius: 70.0,
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(snapshot.data['Name'],
                                        style: TextStyle(
                                          color: Colors.blueAccent,
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
                                        color: Colors.blueAccent,
                                        size: 25,
                                      ),
                                      Text(
                                        "any Department",
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
                                        color: Colors.blueAccent,
                                        size: 25,
                                      ),
                                      Text(
                                        "Clinic Location",
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
                                        Icons.money,
                                        color: Colors.blueAccent,
                                        size: 25,
                                      ),
                                      Text(
                                        "Fees 250 L.E",
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
                                      Container(
                                          margin: EdgeInsets.only(top: 20),
                                          child: RaisedButton(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(20)),
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 15, horizontal: 25),
                                              color: Colors.redAccent,
                                              child: Text(
                                                'Book',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 20),
                                              ),
                                              onPressed: () {})),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    /*Card(
                margin: EdgeInsets.all(25),
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: InkWell(
                  onTap: () {},
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.medical_services_outlined,
                            color: Colors.blueAccent,
                            size: 30,
                          ),

                          SizedBox(
                            width: 5,
                          ),

                          Text(
                            "Doctor's Services",
                            style: TextStyle(
                                color: Colors.black38,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                  color: Colors.blueAccent,
                                  child: Text(
                                    'service 1',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {})),
                          Container(
                              margin: EdgeInsets.only(top: 20),
                              padding: EdgeInsets.only(left: 5, right: 5),
                              child: RaisedButton(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 25),
                                  color: Colors.blueAccent,
                                  child: Text(
                                    'service 2',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                  onPressed: () {})),
                        ],
                      ),
                    ],
                  ),
                ),
              ),*/
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
                            Row(
                              children: [
                                Icon(
                                  Icons.star_half,
                                  color: Colors.blueAccent,
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

                            SizedBox(
                              height: 200, // card height
                              child: PageView.builder(
                                itemCount: 10,
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
                                                        Icon(Icons.star,
                                                            color: Colors.amberAccent,
                                                            size: 25.0),
                                                        Icon(Icons.star,
                                                            color: Colors.amberAccent,
                                                            size: 25.0),
                                                        Icon(Icons.star,
                                                            color: Colors.amberAccent,
                                                            size: 25.0),
                                                        Icon(Icons.star,
                                                            color: Colors.amberAccent,
                                                            size: 25.0),
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
                                                  crossAxisAlignment: CrossAxisAlignment
                                                      .start,
                                                  children: [
                                                    Text(
                                                      "Comment she's good doctor",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 25),
                                                    ),

                                                    Text(
                                                      "23 May 2020",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontSize: 20),
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
