import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'Reviews.dart';
import 'package:firebase_auth/firebase_auth.dart';

Color w = Colors.white;
Color b = Colors.black;

class AdminViewReview extends StatelessWidget{
  FirebaseAuth instance = FirebaseAuth.instance;

  final List<Reviews> Rev = [
    Reviews(name: "Radwa" , Reviewws: "Wow"),
    Reviews(name: "Radwaa" , Reviewws: "Woow"),
    Reviews(name: "Radwaaa", Reviewws: "Wooow" ),
    Reviews(name: "Radwaaaaa", Reviewws: "Wooooow" ),
  ];

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
            ...Rev.map((e){
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
                                    image: AssetImage('assets/img/hospitals/cleopatra.jpg',),
                                  )
                              )
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 20),
                            child : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(e.name, style: TextStyle(color:MainColor, fontSize: 17,fontWeight: FontWeight.bold),),
                                  Text(e.Reviewws, style: TextStyle(color:Colors.black, fontSize: 15),textAlign: TextAlign.left,),
                                  Row(
                                      children: <Widget>[
                                        Icon(Icons.star,color: MainColor,),
                                        Icon(Icons.star,color: MainColor,),
                                        Icon(Icons.star,color: MainColor,),
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
                          onPressed: (){},
                        ),
                      )
                    ],
                  ),
                ),
              );

            }).toList(),
          ],

        ),
      ),
    );
  }

}