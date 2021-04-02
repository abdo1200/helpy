import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Home/home.dart';
import 'package:email_validator/email_validator.dart';

import '../main.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}



class _RegisterState extends State<Register> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  final _formKey = GlobalKey<FormState>();
  @override
  String _email, _password,_name;

  Future CreateUser(_email, _password,_name) async{
    await instance.createUserWithEmailAndPassword(email: _email, password: _password);
    firestoreInstance.collection("users").doc(_email).set(
        {
          "name":_name,
          "email" : _email,
          "password" : _password,
        }).then((value){
      print("success");
    });
    instance.signInWithEmailAndPassword(email: _email, password: _password);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => Home()));
  }
  Widget build(BuildContext context) {
    return Scaffold(
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
                    child: TextFormField(
                      validator: (name){
                        Pattern pattern =
                            r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(name))
                          return 'Invalid username';
                        else
                          return null;

                      },
                      onChanged: (value) {
                        setState(() {
                          this._name=value;
                        });
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Colors.blue,
                          fillColor: Colors.red,
                          hintText: 'Enter Your Name',
                          labelText: 'Name'
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          this._email=value;
                        });
                      },
                      validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                      keyboardType: TextInputType.emailAddress ,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Colors.blue,
                          fillColor: Colors.red,
                          hintText: 'Enter Your email',
                          labelText: 'Email',
                          suffixIcon: Icon(Icons.mail),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          this._password=value;
                        });
                      },
                      keyboardType: TextInputType.text ,
                      obscureText: true,
                      validator: (password){
                        Pattern pattern =
                            r'^(?=.*[0-9]+.*)(?=.*[a-zA-Z]+.*)[0-9a-zA-Z]{6,}$';
                        RegExp regex = new RegExp(pattern);
                        if (!regex.hasMatch(password))
                          return 'Invalid password';
                        else
                          return null;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          focusColor: Colors.blue,
                          fillColor: Colors.red,
                          hintText: 'Enter Your password',
                          labelText: 'Password',
                          suffixIcon: Icon(Icons.lock),
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
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                        }
                        CreateUser(_email,_password,_name);
                      },
                      child: Text("Sign Up",style: TextStyle(color: Colors.white,fontSize: 18),),
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
