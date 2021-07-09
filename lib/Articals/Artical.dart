import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';


import '../main.dart';

class Artical extends StatefulWidget {
  final String id;
  const Artical(this.id);
  @override
  _ArticalState createState() => _ArticalState();
}

class _ArticalState extends State<Artical> {
  FirebaseAuth instance = FirebaseAuth.instance;
  String Content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Artical'),
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
      body: SingleChildScrollView(
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('Articles')
                .doc(widget.id) //ID OF DOCUMENT
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Text("Loading");
              }
              var userDocument = snapshot.data;
              return Column(
                children: [
                  Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                        image: DecorationImage(
                            image: NetworkImage(userDocument["image"]),
                            fit: BoxFit.cover
                        )
                    ),
                  ),
                  // title
                  Container(
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.only(top: 20,right: 10,bottom: 10),
                    child: Text(
                      userDocument["Title"],
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          height: 1
                      ),textAlign:TextAlign.end,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          border: Border.all(color: MainColor,width: 2,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        margin: EdgeInsets.only(right: 10),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        alignment: Alignment.centerRight,
                        child: Text(
                          userDocument["date"],
                          style: TextStyle(
                              color: MainColor,
                              fontSize: 15),
                          textAlign:TextAlign.end,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),

                  //content
                  Container(
                    padding: EdgeInsets.only(right: 10,left: 20,bottom: 20),
                    child: Text(userDocument["Content"].replaceAll("\\n", "\n"),
                      textAlign: TextAlign.end,
                    ),

                  ),

                  //comment
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: TextField(
                      onChanged: (value) {
                        setState(() {
                          this.Content=value;
                        });
                      },
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        focusColor: Colors.blue,
                        fillColor: Colors.red,
                        hintText: 'Leave Comment',
                      ),
                    ),
                  ),
                  //submit button
                  Container(
                    margin: EdgeInsets.all(20),
                    child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20), child: Text("Submit", style: TextStyle(color: Colors.white, fontSize: 20)),
                        color: MainColor,
                        onPressed: () async {
                          DocumentReference ref = await FirebaseFirestore.instance.collection('Comments').add({
                            'Content': Content,
                            'id': widget.id,
                            'email':instance.currentUser.email,
                            'date':DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            'hour':DateFormat('hh:mm').format(DateTime.now())
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(backgroundColor: Colors.green,content: Text('Reservation is Added Successfully')));
                        }
                    ),
                  ),
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance.collection('Comments').where('id',isEqualTo: widget.id).snapshots(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Something went wrong');
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("Loading");
                      }
                      return new Column(
                        children: snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data();
                            return Container(
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 10,right: 10,bottom: 10),
                              padding: EdgeInsets.only(top: 10,bottom: 10,left: 10),
                              decoration: BoxDecoration(
                                border: Border.all(color: MainColor,width: .5,style: BorderStyle.solid),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('${data['email']}',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 10),textAlign: TextAlign.left,
                                      ),
                                      SizedBox(width: 10,),
                                      Row(
                                        children: [
                                          Text('${data['date']}',
                                            style: TextStyle(
                                                color: MainColor,
                                                fontSize: 10),textAlign: TextAlign.left,
                                          ),
                                          SizedBox(width: 10,),
                                          Text('${data['hour']}  ',
                                            style: TextStyle(
                                                color: MainColor,
                                                fontSize: 10),textAlign: TextAlign.left,
                                          ),
                                        ],)
                                    ],
                                  ),
                                  SizedBox(height: 5,),
                                  Text('${data['Content']}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15),textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                            );

                        }).toList(),
                      );
                    },
                  ),
                ],
              );
            }
        )
      ),
    );
  }
}
