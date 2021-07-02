import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'Reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color w = Colors.white;
Color b = Colors.black;

class AdminViewReview extends StatefulWidget{
  String id;
  AdminViewReview(this.id);
  @override
  _AdminViewReviewState createState() => _AdminViewReviewState();
}

class _AdminViewReviewState extends State<AdminViewReview> {
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Reviews'),
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

      body: Container(
        margin: EdgeInsets.only(top: 10),
        width: double.infinity,
        child: Column(
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('Reviews').where('hospid',isEqualTo: widget.id).snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }
                  if(snapshot.data.docs.isNotEmpty){
                    return new ListView(
                      shrinkWrap: true,
                      children: snapshot.data.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data();
                        return StreamBuilder(
                          stream: FirebaseFirestore.instance.collection('users').doc('${data['email']}').snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) return const Text('loading');
                            return Container(
                              margin: EdgeInsets.only(bottom: 5),
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Container(
                                            width: 50.0,
                                            height: 50.0,
                                            margin: EdgeInsets.only(left:10),
                                            decoration: new BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: new DecorationImage(
                                                    fit: BoxFit.fill,
                                                    image: NetworkImage(snapshot.data['imageurl'])
                                                )
                                            )
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 20),
                                          child : Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(snapshot.data['name'], style: TextStyle(color:MainColor, fontSize: 17,fontWeight: FontWeight.bold),),
                                                Text('${data['comment']}', style: TextStyle(color:Colors.black, fontSize: 15),textAlign: TextAlign.left,),
                                                Row(
                                                    children: <Widget>[
                                                      for(int i=0;i<data['rate'];i++)
                                                        Icon(Icons.star,color: MainColor,),
                                                    ]
                                                ),

                                              ]
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      child: IconButton(
                                        icon: Icon(Icons.delete_forever,color: Colors.red,size: 40,),
                                        onPressed: (){
                                          FirebaseFirestore.instance.collection("Reviews").doc(document.id).delete();
                                        },
                                      ),
                                    )
                                  ],
                                )
                              ),
                            );
                          },
                        );


                      }).toList(),
                    );}
                  else{
                    return Container(
                      margin: EdgeInsets.only(top: 100),
                      child: Text("No Hospitals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    );
                  }
                }
            ),

          ],

        ),
      ),
    );
  }
}