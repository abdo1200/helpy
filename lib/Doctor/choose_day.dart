import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:intl/intl.dart';
import '../main.dart';
import 'choose_hour.dart';
import 'doctor_profile.dart';

class ChooseDay extends StatefulWidget {
  String id, name;
  ChooseDay(this.id, this.name);
  @override
  _ChooseDayState createState() => _ChooseDayState();
}

class _ChooseDayState extends State<ChooseDay> {
  final _formKey = GlobalKey<FormState>();
  DateTime _selectedDate;
  final _text = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Confirm Patient Day'),
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
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top: 200, left: 10, right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: MainColor, style: BorderStyle.solid, width: 2)),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
                    color: MainColor,
                    child: Text(
                      "Book your Dr",
                      style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 10,
                          color: Colors.white),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                    child: TextFormField(
                      controller: _text,
                      validator: (value) {
                        if (value == null) {
                          return '*Please Choose Role';
                        }
                        return null;
                      },
                      onTap: () {
                        _selectDate(context);
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Choose Day',
                        labelText: 'Choose Day',
                        suffixIcon:
                            Icon(Icons.calendar_today, color: MainColor),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width * .3,
                        right: MediaQuery.of(context).size.width * .3),
                    child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      color: MainColor,
                      child: Text(
                        "Next",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      onPressed: () async {
                        if (_selectedDate == null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(backgroundColor: Colors.red,content: Text('Choose Day First')));
                        }
                        else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ChooseHour(
                                          widget.id, widget.name,
                                          _selectedDate)));
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2040),
    );

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _text
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _text.text.length, affinity: TextAffinity.upstream));
    }
  }
}
