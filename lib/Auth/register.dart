import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
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
  String _email, _password,_name,_phone,_birthday,_gender,_address;
  File _userImageFile;
  String imgurl;
  var areas = [
    "Nasr City",
    "Maadi",
  ];
  Future getimage () async{
    var image= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _userImageFile=image;
      print(_userImageFile);
    });
  }
  Future CreateUser(_email, _password,_name,String img) async{
    await instance.createUserWithEmailAndPassword(email: _email, password: _password);
    firestoreInstance.collection("users").doc(_email).set(
        {
          "name":_name,
          "email" : _email,
          "password" : _password,
          "address": _address,
          "phone":_phone,
          "gender":_gender,
          "birthday":_birthday,
          'imageurl':img,
          'rule':'member'
        }).then((value){
      print("success");
    });
  }
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
                      keyboardType: TextInputType.name ,
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
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          this._phone=value;
                        });
                      },
                      keyboardType: TextInputType.number ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Enter Your phone',
                        labelText: 'phone',
                        suffixIcon: Icon(Icons.phone_android),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          this._gender=value;
                        });
                      },
                      keyboardType: TextInputType.text ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Enter Your Gender',
                        labelText: 'Gender',
                        suffixIcon: Icon(Icons.people),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: DropdownButtonFormField(
                      items: areas.map((String area) {
                        return new DropdownMenuItem(
                            value: area,
                            child: Row(
                              children: <Widget>[
                                Text(area),
                              ],
                            )
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        // do other stuff with _category
                        setState(() => _address = newValue);
                      },
                      value: _address,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        labelText: 'ِaddress',
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: Text(
                            'Images',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Container(
                          child: Row(
                            children: <Widget>[
                              RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)
                                ),
                                color: Colors.white,
                                child: (_userImageFile!=null)?Container(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50)
                                  ),
                                  child: Row(children: <Widget>[
                                    Image.file(_userImageFile,width: 70,height: 70,),
                                    SizedBox(width: 20,),
                                    Icon(Icons.add_a_photo,color: MainColor,),
                                    SizedBox(width: 10,),
                                    Text("Change Image",style: TextStyle(color: MainColor,fontSize: 15)),
                                  ],),
                                ):
                                Row(
                                  children: [
                                    Icon(Icons.add_a_photo,color: MainColor,),
                                    SizedBox(width: 10,),
                                    Text("Choose image",style: TextStyle(color: MainColor,fontSize: 15),),
                                  ],
                                ),
                                onPressed: (){
                                  getimage();
                                },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          this._birthday=value;
                        });
                      },
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Enter Your Birthday',
                        labelText: 'Birthday',
                        suffixIcon: Icon(Icons.calendar_today),
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
                      onPressed: () async{
                        if(_formKey.currentState.validate()){
                          _formKey.currentState.save();
                        }
                        Reference storageReference = FirebaseStorage.instance.ref().child(basename(_userImageFile.path));
                        UploadTask uploadTask = storageReference.putFile(_userImageFile);
                        await uploadTask.whenComplete((){
                          print('File Uploaded');
                          storageReference.getDownloadURL().then((fileURL) {
                            setState(() {
                              imgurl = fileURL;
                              CreateUser(_email,_password,_name,imgurl);
                              instance.signInWithEmailAndPassword(email: _email, password: _password);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(

                                      builder: (context) => UserHome('member')));
                            });
                          });
                        });

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
