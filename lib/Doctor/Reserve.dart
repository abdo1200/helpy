import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../main.dart';
import 'doctor.dart';

class Reserve extends StatefulWidget {
  String id, name;
  DateTime _selectedDate;
  int hour;
  Reserve(this.id, this.name, this._selectedDate, this.hour);
  @override
  _ReserveState createState() => _ReserveState();
}

class _ReserveState extends State<Reserve> {
  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  final _text = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  String patientName, patientNumber ;
  CollectionReference documents =
      FirebaseFirestore.instance.collection('reservation');
  Future<void> ReserveAppointment(
      String Dr_id, String Dr_name, DateTime _selectedDate, int hour) {
    var current_user = auth.currentUser;
    return documents
        .add({
          'Dr_id': Dr_id,
          'Dr_name': Dr_name,
          'patientName': patientName,
          'patientNumber': patientNumber,
          'selectedDate': _selectedDate,
          'selectedTime': hour,
          'user': {
            'uid': current_user.uid,
            'email': current_user.email,
          }
        })
        .then((value) => print("Reservation Added Successfully"))
        .catchError((error) => print("Failed to Reserve: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Confirm Patient Data'),
      ),
      body: Stack(children: [
        Container(
          margin: EdgeInsets.only(top: 100),
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                //name
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Patient Name',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return '*Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          patientName = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 20, top: 20),
                      child: Text(
                        'Patient Number',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null) {
                            return '*Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          patientNumber = value;
                        },
                        decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          contentPadding: EdgeInsets.only(
                              left: 10, bottom: 11, top: 11, right: 15),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * .3,
                      right: MediaQuery.of(context).size.width * .3),
                  child: RaisedButton(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    color: Colors.white,
                    child: Text(
                      "Reserve",
                      style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: MainColor),
                    ),
                    onPressed: () async {
                      if (patientName == null || patientNumber == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    '*Required Field',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 18.0))));
                      } else {
                        ReserveAppointment(widget.id, widget.name,
                            widget._selectedDate, widget.hour);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(backgroundColor: Colors.green,content: Text('Reservation is Added Successfully')));
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => Doctor()));
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
