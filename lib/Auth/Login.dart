import 'package:flutter/material.dart';
import 'package:helpy/Layouts/Appbar.dart';
import 'package:helpy/main.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/img/loginback.png'),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 170),
              padding: EdgeInsets.only(left: 20,right: 40),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusColor: Colors.blue,
                    fillColor: Colors.red,
                    hintText: 'Enter your username',
                    labelText: 'UserName'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20,right: 40),
              child: TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    focusColor: Colors.blue,
                    fillColor: Colors.red,
                    hintText: 'Enter Your Password',
                    labelText: 'Password'
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              padding: EdgeInsets.only(left: 20,right: 40),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                padding: EdgeInsets.symmetric(vertical: 15,horizontal: 25),
                color: MainColor,
                child: Text('Login',style: TextStyle(color: Colors.white,fontSize: 20),),
                onPressed: (){},
              )
            )
          ],
        ),
      ),
    );
  }
}
