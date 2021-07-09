import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../main.dart';
import 'Reserve.dart';

class ChooseHour extends StatefulWidget {
  String id, name;
  DateTime _selectedDate;
  ChooseHour(this.id, this.name, this._selectedDate);
  @override
  _ChooseHourState createState() => _ChooseHourState();
}

class _ChooseHourState extends State<ChooseHour> {
  int hour = 1;
  bool _exist = false;
  int j=0;
  List<Color> colors = [MainColor, MainColor,MainColor,MainColor,MainColor,MainColor,MainColor,MainColor,MainColor,MainColor];
  DateTime _selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var existHours = [];
    // for(int j=0;j<10;j++){
    //   colors[j]=MainColor;
    // }
    FirebaseFirestore.instance
        .collection('reservation')
        .where('selectedDate', isEqualTo: widget._selectedDate)
        .where('Dr_id', isEqualTo: widget.id)
        .snapshots()
        .listen((data) {
        data.docs.forEach((doc) => existHours.add(doc["selectedTime"]));

    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Confirm Patient Hour'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 100, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: MainColor, style: BorderStyle.solid, width: 2)),
            child: Column(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                  color: MainColor,
                  child: Text(
                    "Choose Time",
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 10,
                        color: Colors.white),
                  ),
                ),

                for(int i=0;i<10;i++)
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)),
                    color: colors[i],
                    child: Text(
                      "${i+1} PM",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    onPressed: () async {
                      setState(() {
                        hour = i+1;
                        if (existHours.contains(hour)) {
                          _exist = true;
                          colors[i]=Colors.grey;
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Time is taken , choose another one',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0))));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Reserve(
                                      widget.id,
                                      widget.name,
                                      widget._selectedDate,
                                      hour)));
                        }
                      });
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
