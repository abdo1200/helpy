import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddHospital extends StatefulWidget {
  AddHospital({Key key}) : super(key: key);

  @override
  _AddHospitalState createState() => _AddHospitalState();
}

class _AddHospitalState extends State<AddHospital> {
  FirebaseAuth instance = FirebaseAuth.instance;
  File _userImageFile;
  String imgurl;
  var nameController,
      emailController,
      addressController,
      numberController,
      servicesController;
  @override

  Future getimage () async{
    var image= await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _userImageFile=image;
      print(_userImageFile);
    });
  }
  Future uploadFile() async {
    Reference storageReference = FirebaseStorage.instance.ref().child(basename(_userImageFile.path));
    UploadTask uploadTask = storageReference.putFile(_userImageFile);
    await uploadTask.whenComplete((){
      print('File Uploaded');
      storageReference.getDownloadURL().then((fileURL) {
        setState(() {
          imgurl = fileURL;
          print(imgurl);
        });
      });
    });
  }
  Future Make_movie(String imgurl2) async{
    DocumentReference ref = await FirebaseFirestore.instance
        .collection('Hospitals').add({
      'name': nameController,
      'email': emailController,
      'address': addressController,
      'Rate': 1,
      'imageurl':imgurl2,
      'phone':numberController,
      'service':servicesController
    });

    print('movie added');
  }
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor,
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text('Add Hospital Form'),
          actions: <Widget>[
            IconButton(
              onPressed: () {
                instance.signOut();
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Login()));
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
        body: Stack(
          children: [
            Container(
              padding: EdgeInsets.only(left: 20,right: 20),
              child: Form(
                child: ListView(
                  children: <Widget>[
                    //name
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 20),
                          child: Text(
                            'Hospital name',
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 10, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.nameController=value;
                            },
                          ),
                        ),
                      ],
                    ),

                    //email
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Email',
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.emailController=value;
                            },
                          ),
                        ),
                      ],
                    ),

                    //address
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Address',
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.addressController=value;
                            },
                          ),
                        ),
                      ],
                    ),

                    //phone
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Phone number',
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.numberController=value;
                            },
                          ),
                        ),
                      ],
                    ),

                    //image
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Images',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.all(10),
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
                                    Text("Change Image",style: TextStyle(color: MainColor,fontSize: 20)),
                                  ],),
                                ):Row(
                                  children: [
                                    Icon(Icons.add_a_photo,color: MainColor,),
                                    SizedBox(width: 10,),
                                    Text("Choose image",style: TextStyle(color: MainColor,fontSize: 20),),
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

                    //services
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Services',
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
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 15, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.servicesController=value;
                            },
                          ),
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
                        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                        ),
                        color: Colors.white,
                        child: Text(
                          "Submit",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: MainColor
                          ),
                        ),
                        onPressed: () async{
                          Reference storageReference = FirebaseStorage.instance.ref().child(basename(_userImageFile.path));
                          UploadTask uploadTask = storageReference.putFile(_userImageFile);
                          await uploadTask.whenComplete((){
                            print('File Uploaded');
                            storageReference.getDownloadURL().then((fileURL) {
                              setState(() {
                                imgurl = fileURL;
                                Make_movie(imgurl);
                              });
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
