import 'package:flutter/material.dart';
import 'package:helpy/Auth/Register_doctor.dart';
import 'package:helpy/Auth/register.dart';

import '../main.dart';

class ChooseRule extends StatefulWidget {
  @override
  _ChooseRuleState createState() => _ChooseRuleState();
}

class _ChooseRuleState extends State<ChooseRule> {
  final _formKey = GlobalKey<FormState>();
String choosen;
  var Rule = [
    "member",
    "doctor",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: EdgeInsets.only(top:50,left: 10,right: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: MainColor,style: BorderStyle.solid,width: 2)
            ),
            child: Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.symmetric(vertical: 10,horizontal: 30),
                    color: MainColor,
                    child: Text("Registration",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold,letterSpacing: 10,color: Colors.white),),
                  ),



                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: DropdownButtonFormField(
                      items: Rule.map((String area) {
                        return new DropdownMenuItem(
                            value: area,
                            child: Row(
                              children: <Widget>[
                                Text(area),
                              ],
                            )
                        );
                      }).toList(),
                      validator: (value) {
                        if (choosen == null) {
                          return '*Please Choose Role';
                        }
                        return null;
                      },
                      onChanged: (newValue) {
                        // do other stuff with _category
                        setState(() => choosen = newValue);
                      },
                      value: choosen,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        labelText: 'Rule',
                      ),
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20,bottom: 20),
                    child: RaisedButton(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      color: MainColor,
                      onPressed: () {
                        if(choosen=='doctor'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddDoctor()));
                        }else if(choosen == 'member'){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
                        }
                        else if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      '*Required Field',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0))));
                        }
                      },
                      child: Text("Next",style: TextStyle(color: Colors.white,fontSize: 18),),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
