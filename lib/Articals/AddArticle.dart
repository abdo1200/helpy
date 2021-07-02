import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:io';
import 'package:path/path.dart';

class AddArticle extends StatefulWidget {
  @override
  _AddArticleState createState() => _AddArticleState();
}

class _AddArticleState extends State<AddArticle> {
  FirebaseAuth instance = FirebaseAuth.instance;
  File _userImageFile;
  String imgurl;
  String content,title,date;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: MainColor,
        appBar: AppBar(
          backgroundColor: MainColor,
          title: Text('Add Article'),
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
                            'Title',
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
                              this.title=value;
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

                    //Content
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(left: 20,top: 10),
                          child: Text(
                            'Content',
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
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              focusedBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              contentPadding: EdgeInsets.only(
                                  left: 10, bottom: 11, top: 11, right: 15),
                            ),
                            onChanged: (value){
                              this.content=value;
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
                                FirebaseFirestore.instance
                                    .collection('Articles').add({
                                  'Title': title,
                                  'Content': content,
                                  'date' : DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                  'image': imgurl,
                                });
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
