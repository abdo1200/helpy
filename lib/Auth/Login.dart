import 'package:flutter/material.dart';
import 'package:helpy/Auth/register.dart';
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

  var loginkey = GlobalKey<ScaffoldState>();
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: 700,
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Register()));
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Home()));

                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
//                            loginkey.currentState.showSnackBar(SnackBar(
//                              content: Text('user not found'),
//                            ));
                          print("user not found");
                        } else if (e.code == 'wrong-password') {
//                            loginkey.currentState.showSnackBar(SnackBar(
//                              content: Text('wrong password'),
//                            ));
                        } else if (e.code == 'invalid-email') {
//                            loginkey.currentState.showSnackBar(SnackBar(
//                              content: Text('invalid email'),
//                            ));
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
