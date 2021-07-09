import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'Reserve.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color w = Colors.white;
Color b = Colors.black;

class viewReservations extends StatefulWidget {
  String id;
  viewReservations(this.id);

  @override
  _viewReservationsState createState() => _viewReservationsState();
}

class _viewReservationsState extends State<viewReservations> {
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Reservations'),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              instance.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (context) => Login()));
            },
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.white,
              size: 20,
            ),
          ),
        ],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 20),
            width: double.infinity,
            child: Column(
              children: <Widget>[
                StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('reservation')
                        .where('Dr_id', isEqualTo: widget.id)
                        .orderBy('selectedDate', descending: false)
                        .snapshots(), //.orderBy('selectedDate',descending: false)
                    builder: (BuildContext context,
                        AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      if (snapshot.data.docs.isNotEmpty) {
                        return new ListView(
                          shrinkWrap: true,
                          children: snapshot.data.docs
                              .map((DocumentSnapshot document) {
                            return StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection('reservation')
                                  .doc('${document['Dr_name']}')
                                  .snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData)
                                  return const Text('loading');
                                return Container(
                                  margin: EdgeInsets.only(top: 30),
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: Card(
                                    margin:
                                        EdgeInsets.only(left: 30, right: 30),
                                    clipBehavior: Clip.antiAlias,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: InkWell(
                                      onTap: () {},
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 50,
                                                top: 20,
                                                right: 50,
                                                bottom: 30),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 3,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.account_box,
                                                      color: Colors.blueAccent,
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      document['patientName'],
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.phone,
                                                      color: Colors.blueAccent,
                                                      size: 25,
                                                    ),
                                                    Text(
                                                      document['patientNumber'],
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Icon(
                                                      Icons.calendar_today,
                                                      color: Colors.blueAccent,
                                                      size: 22,
                                                    ),
                                                    Text(
                                                      "${DateFormat.MMMd().format(document['selectedDate'].toDate())} at ${document['selectedTime']}:00PM",
                                                      style: TextStyle(
                                                          color: Colors.black38,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        );
                      } else {
                        return Container(
                          margin: EdgeInsets.only(top: 100),
                          child: Text(
                            "No Reservations",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      }
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
