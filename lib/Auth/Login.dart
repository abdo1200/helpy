import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/ChooseRole.dart';
import 'package:helpy/Auth/register.dart';
import 'package:helpy/Home/AdminHome.dart';
import 'package:helpy/Home/DoctorHome.dart';
import 'package:helpy/Home/MemberHome.dart';
import 'package:helpy/Home/home.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool visibal = true;
  String _email, _password;
  final _formKey = GlobalKey<FormState>();

  FirebaseAuth instance = FirebaseAuth.instance;

  Future SendRule(String email) async{
    await FirebaseFirestore.instance.collection('users').doc(email).get().then((value){
      if(email=='admin@admin.com'){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AdminHome()));
      }else{
        if(value['rule']=='member'){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => MemberHome()));
        }else if(value['rule']=='doctor'){
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorHome()));
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 700,
          width: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/img/loginback.png'),
                  fit: BoxFit.cover)),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 170),
                  padding: EdgeInsets.only(left: 20,right: 40),
                  child: TextFormField(
                    validator: (email)=>EmailValidator.validate(email)? null:"Invalid email address",
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Enter your username',
                        labelText: 'UserName'
                    ),

                    onChanged: (value) {
                      setState(() {
                        this._email = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.only(left: 20,right: 40),
                  child: TextFormField(
                    onChanged: (value) {
                      setState(() {
                        this._password = value;
                      });
                    },
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return '*Required Field';
                      }
                      return null;
                    },
                    obscureText: true,
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
                  margin: EdgeInsets.only(left: 20,top: 10),
                  child: Row(
                    children: <Widget>[
                      Text("Not registered , ",style: TextStyle(fontSize: 15),),
                      InkWell(
                        onTap: (){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChooseRule()));
                        },
                        child: Text("Create an account",style:TextStyle(fontSize: 17,fontWeight: FontWeight.bold,color:Colors.blue[900])),
                      )
                    ],
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
                    onPressed: ()async {
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                      }
                      try {
                        await instance.signInWithEmailAndPassword(email: _email, password: _password);
                        SendRule(_email);
                      }on FirebaseAuthException catch (e) {
                        if (_formKey.currentState.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text(
                                      'Enter Valid Email & Password',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18.0))));
                        }
                        if (e.code == 'invalid-email') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('invalid-email',
                                style: TextStyle(color: Colors.white,fontSize: 18.0)),
                          ));
                        }
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('user-not-found',
                                style: TextStyle(color: Colors.white,fontSize: 18.0)),
                          ));
                        }
                        if (e.code == 'wrong-password') {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('wrong-password',
                                style: TextStyle(color: Colors.white,fontSize: 18.0)),
                          ));
                        }
                      }
                    },
                  )
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
