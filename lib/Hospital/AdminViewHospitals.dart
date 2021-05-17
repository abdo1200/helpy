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
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
          ...Rev.map((e){
             return InkWell(
               onTap: (){
                 Navigator.push(
                     context, MaterialPageRoute(builder: (context) => AdminViewSpecificHospital()));
               },
               child: Card(
                 margin: EdgeInsets.only(top: 20),
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.circular(20)
                 ),
                 elevation: 2,
                   child :Container(
                     width: 300,
                     decoration: BoxDecoration(
                     ),
                    child: Column(
                     children: [
                       //image
                       Container(
                         width: 300,
                         margin: EdgeInsets.only(bottom: 10),
                         height: 100,
                         decoration: new BoxDecoration(
                               borderRadius:BorderRadius.circular(20),
                               image: new DecorationImage(
                                 fit: BoxFit.fill,
                                 image: AssetImage('assets/img/hospitals/cleopatra.jpg',),
                               )
                           )
                       ),

                       //name
                       Text(e.name, style: TextStyle(color:Colors.blueAccent, fontSize: 20,fontWeight: FontWeight.bold),),

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
             );
            }).toList(),
    ],
          ),
        ),
      ),
    );

  }

}