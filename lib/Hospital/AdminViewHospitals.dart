import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Reviews/Reviews.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Admin/AdminViewSpecificHospital.dart';

class AdminViewHospitals extends StatelessWidget{
  FirebaseAuth instance = FirebaseAuth.instance;
  final List<Reviews> Rev = [
    Reviews(name: "Egyption Hospital" , Reviewws: "Wow"),
    Reviews(name: "Egyption Hospital" , Reviewws: "Woow"),
    Reviews(name: "Egyption Hospital", Reviewws: "Wooow" ),
    Reviews(name: "Egyption Hospital", Reviewws: "Wooooow" ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MainColor,
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Hospitals'),
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
        width: double.infinity,
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Hospitals').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text('Something went wrong');
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text("Loading");
            }
            if(snapshot.data.docs.isNotEmpty){
              return new ListView(
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data();
                  return Container(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) => AdminViewSpecificHospital(document.id)));
                      },
                      child: Card(
                        margin: EdgeInsets.only(top: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                        elevation: 2,
                        child :Container(
                          decoration: BoxDecoration(
                          ),
                          child: Column(
                            children: [
                              //image
                              Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  height: 150,
                                  decoration: new BoxDecoration(
                                      borderRadius:BorderRadius.circular(20),
                                      image: new DecorationImage(
                                        image: NetworkImage('${data['imageurl']}'),
                                        fit: BoxFit.cover,
                                      )
                                  )
                              ),

                              //name
                              Text('${data['name']}', style: TextStyle(color:Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.bold),),

                              //stars
                              Container(
                                margin: EdgeInsets.only(top: 5,bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.star,color: MainColor,),
                                    Icon(Icons.star,color: MainColor,),
                                    Icon(Icons.star,color: MainColor,),
                                    Icon(Icons.star,color: MainColor,),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              );}
            else{
              return Container(
                margin: EdgeInsets.only(top: 100),
                child: Text("No Hospitals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              );
            }
          },
        ),
      ),
    );

  }

}