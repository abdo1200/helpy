import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/User/user_profile.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';


class EditProfile extends StatefulWidget {
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  FirebaseAuth instance = FirebaseAuth.instance;
  String _email,_name,_phone,_birthday,_gender,_address,_imageurl;
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('users').where('email',isEqualTo: instance.currentUser.email).snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            _email=snapshot.data.docs[0].data()['email'];
            _address=snapshot.data.docs[0].data()['address'];
            _gender=snapshot.data.docs[0].data()['gender'];
            _phone=snapshot.data.docs[0].data()['phone'];
            _email=snapshot.data.docs[0].data()['email'];
            _name=snapshot.data.docs[0].data()['name'];
            _birthday=snapshot.data.docs[0].data()['birthday'];
            _imageurl=snapshot.data.docs[0].data()['imageurl'];
            return Column(
              children: [
                Container(
                  // background
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 25),
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(28, 117, 201, 1),
                    borderRadius: BorderRadius.only(
                        bottomLeft: const Radius.circular(60.0),
                        bottomRight: const Radius.circular(60.0)),
                  ),
                  child: Column(
                    children: [
                      // app bar
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 5,left: 5),
                            decoration: BoxDecoration(
                                color:MainColor,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.arrow_back),
                              onPressed: (){
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5,right: 5),
                            decoration: BoxDecoration(
                                color:MainColor,
                                borderRadius: BorderRadius.circular(60)
                            ),
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.exit_to_app),
                              onPressed: (){
                                instance.signOut();
                                Navigator.pushReplacement(
                                    context, MaterialPageRoute(builder: (context) => Login()));
                              },
                            ),
                          ),

                        ],
                      ),
                      // image
                      Container(
                        margin: EdgeInsets.only(top: 40.0),
                        child: CircleAvatar(
                          backgroundImage: (_userImageFile!=null)?FileImage(_userImageFile):NetworkImage(_imageurl),
                          radius: 50.0,
                          child: Container(
                            margin: EdgeInsets.only(top: 60,left:60),
                            decoration: BoxDecoration(
                              //color: Colors.white,
                              borderRadius: BorderRadius.circular(50)
                            ),
                            child: IconButton(
                              icon: Icon(Icons.add_a_photo_rounded,color: Colors.white,size: 30,),
                              onPressed: (){
                                getimage();
                              },
                            ),
                          ),
                        ),
                      ),
                      // name
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 90),
                        margin: EdgeInsets.only(top: 20.0),
                        child: TextFormField(
                          initialValue: _name,
                          onChanged: (value) {
                              this._name=value;
                          },
                          keyboardType: TextInputType.name ,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name'
                          ),
                        ),
                      ), // user name
                    ],
                  ),
                ),
                //email
                FractionallySizedBox(
                  widthFactor: .95,
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(left: 30,right: 30),
                    child: TextFormField(
                      initialValue: _email,
                      onChanged: (value) {
                          this._email=value;
                      },
                      keyboardType: TextInputType.emailAddress ,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        suffixIcon: Icon(Icons.mail,color: MainColor,),
                      ),
                    ),
                  ),
                ),
                // phone and gender
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: .95,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0, right: 5),
                          padding: EdgeInsets.only(top:2.0,bottom: 2),
                          child: TextFormField(
                            initialValue: _phone,
                            onChanged: (value) {
                                this._phone=value;
                            },
                            keyboardType: TextInputType.number ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'phone',
                              suffixIcon: Icon(Icons.phone_android,color: MainColor,),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: FractionallySizedBox(
                        widthFactor: .95,
                        child: Container(
                          margin: const EdgeInsets.only(top: 20.0,right: 5),
                          padding: EdgeInsets.only(top:2.0,bottom: 2),
                          child: TextFormField(
                            initialValue: _gender,
                            onChanged: (value) {
                                this._phone=value;
                            },
                            keyboardType: TextInputType.number ,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Gender',
                              suffixIcon: Icon(Icons.phone_android,color: MainColor,),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                //address
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
                      _address = newValue;
                    },
                    value: _address,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'ِaddress',
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .55,
                  child: Container(
                    margin: const EdgeInsets.only(top: 20.0),
                    padding: EdgeInsets.all(2.0),
                    child: TextFormField(
                      initialValue: _birthday,
                      onChanged: (value) {
                          this._birthday=value;
                      },
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Birthday',
                        suffixIcon: Icon(Icons.calendar_today,color: MainColor,),
                      ),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: .30,
                  child: Container(
                    height: 50,
                    margin: EdgeInsets.only(top: 25,bottom: 20),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      color: Color.fromRGBO(28, 117, 201, 1),
                      onPressed: () async{
                        Reference storageReference = FirebaseStorage.instance.ref().child(basename(_userImageFile.path));
                        UploadTask uploadTask = storageReference.putFile(_userImageFile);
                        await uploadTask.whenComplete(()async{
                          Reference storageReference = await FirebaseStorage.instance
                              .refFromURL(_imageurl);
                          storageReference.delete().then((value) => print("file deleted"));
                          print('File Uploaded');
                          storageReference.getDownloadURL().then((fileURL) {
                            setState(() {
                              imgurl = fileURL;
                              FirebaseFirestore.instance.collection('users').doc(instance.currentUser.email)
                                  .update({
                                'name': _name,
                                'address':_address,
                                'email':_email,
                                'birthday':_birthday,
                                'gender':_gender,
                                'phone':_phone,
                                'imageurl':imgurl
                              })
                                  .then((value) => print("User Updated"))
                                  .catchError((error) => print("Failed to update user: $error"));
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => UserProfile()));
                            });
                          });
                        });
                      },
                      child: Row(
                        children: [
                          Icon(
                              Icons.save,
                              color: Colors.white,
                            ),
                          Text('Save',
                              style: TextStyle(fontSize: 18, color: Colors.white)),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
