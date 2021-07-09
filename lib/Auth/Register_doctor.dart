import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../main.dart';


class AddDoctor extends StatefulWidget {
  @override
  _AddDoctorState createState() => _AddDoctorState();
}


class _AddDoctorState extends State<AddDoctor> {

  String Name ,
      Email ,
      Number,
      Address,
      Specialization , Fees ,Password;
  final _formKey = GlobalKey<FormState>();
  String dropdownValue = 'Select Specialization';
  File _userImageFile;
  String imgurl;
  Future getimage () async{
    var image= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _userImageFile=image;
      print(_userImageFile);
    });
  }

  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference documents =
      FirebaseFirestore.instance.collection('users');
  Future<void> addDoctor(Email, Password,String img) async {
    // Call the user's CollectionReference to add a new user
    await instance.createUserWithEmailAndPassword(email: Email, password: Password);
    return documents.doc(Email)
        .set({
          'name': Name,
          'email': Email,
          'password': Password,
          'rule':'doctor',
          'phone': Number,
          'imageurl': img,
          'address': Address,
          'Specialization': Specialization,
          'Fees': Fees,
          'rate':3

        })
        .then((value) => print("Doctor Added Successfully"))
        .catchError((error) => print("Failed to add Doctor: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text('Doctor Form'),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.only(top:20,left: 10,right: 10,bottom: 20),
              padding: EdgeInsets.only(bottom: 20),
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
                    //name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required Field';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              Name = value;
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
                      ],
                    ),

                    //email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required Field';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              Email = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Colors.blue,
                                fillColor: Colors.red,
                                hintText: 'Enter Your Email',
                                labelText: 'Email'
                            ),
                          ),
                        ),
                      ],
                    ),
                    //password
                    Container(
                      margin: EdgeInsets.only(top: 10,bottom: 10),
                      padding: EdgeInsets.only(left: 10,right: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return '*Required Field';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            this.Password=value;
                          });
                        },
                        keyboardType: TextInputType.text ,
                        obscureText: true,
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
                    //address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required Field';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              Address = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Colors.blue,
                                fillColor: Colors.red,
                                hintText: 'Enter Clinic Address',
                                labelText: 'Clinic Address'
                            ),
                          ),
                        ),
                      ],
                    ),
                    //phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required Field';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              Number = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Colors.blue,
                                fillColor: Colors.red,
                                hintText: 'Enter Clinic Phone',
                                labelText: 'Clinic phone'
                            ),
                          ),
                        ),
                      ],
                    ),
                    //image
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      padding: EdgeInsets.only(left: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
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
                    //fees
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: TextFormField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '*Required Field';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              Fees = value;
                            },
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                focusColor: Colors.blue,
                                fillColor: Colors.red,
                                hintText: 'Enter Your Fees',
                                labelText: 'Fees'
                            ),
                          ),
                        ),
                      ],
                    ),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.grey, style: BorderStyle.solid, width: 1),
                            borderRadius: BorderRadius.circular(5),),
                          margin: EdgeInsets.all(15),
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: new Theme(
                              data: Theme.of(context).copyWith(
                                canvasColor: Colors.white,
                              ),
                              child: DropdownButton<String>(
                                isExpanded: true,
                                value: dropdownValue,
                                icon: const Icon(
                                  Icons.arrow_drop_down_circle,
                                  color: MainColor,
                                  size: 30,
                                ),
                                iconSize: 24,
                                elevation: 16,
                                style: new TextStyle(
                                    inherit: false,
                                    color: MainColor,
                                    //backgroundColor: MainColor,
                                    fontSize: 20),
                                underline: Container(
                                  height: 0,
                                  color: MainColor,
                                ),
                                onChanged: (newValue) {
                                  setState(() {
                                    dropdownValue = newValue;
                                    Specialization = newValue;
                                  });
                                },
                                items: <String>['Select Specialization','Eyes','Children','Chest','Stomach']
                                    .map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              )),
                        ),
                      ],
                    ),
                    //submit btn
                    Container(
                      margin: EdgeInsets.only(top: 20),
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
                          "Submit",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        onPressed: () async {
                          if (Name == null || Email == null|| Number ==null|| Address == null|| Specialization ==null||
                              Fees ==null || Password==null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text(
                                        '*Required Field',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0))));
                          }else{
                            Reference storageReference = FirebaseStorage.instance.ref().child(basename(_userImageFile.path));
                            UploadTask uploadTask = storageReference.putFile(_userImageFile);
                            await uploadTask.whenComplete((){
                              print('File Uploaded');
                              storageReference.getDownloadURL().then((fileURL) {
                                setState(() {
                                  imgurl = fileURL;
                                  addDoctor(Email,Password,imgurl);
                                  instance.signInWithEmailAndPassword(email: Email, password: Password);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => UserHome('doctor')));
                                });
                              });
                            });
                          }

                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));

  }
}
