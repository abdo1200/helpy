import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Hospital/ViewHospital.dart';
import 'package:helpy/Reviews/AdminViewReview.dart';
import 'package:helpy/Reviews/Reviews.dart';
import 'package:helpy/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AdminViewSpecificHospital extends StatefulWidget {
  @override
  _AdminViewSpecificHospitalState createState() => _AdminViewSpecificHospitalState();
}

class _AdminViewSpecificHospitalState extends State<AdminViewSpecificHospital> {
  FirebaseAuth instance = FirebaseAuth.instance;

  final List<Reviews> Rev = [
    Reviews(name: "Radwa" , Reviewws: "it's good hospital"),
    Reviews(name: "Radwaa" , Reviewws: "it's good hospital"),
    Reviews(name: "Radwaaa", Reviewws: "it's good hospital" ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              // image
              Container(
                width: double.infinity,
                height: 250,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/img/hospitals/cleopatra.jpg'),
                        fit: BoxFit.cover
                    )
                ),
                child: Row(
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
              ),
              //border of image
              Container(
                width: double.infinity,
                height: 15,
                decoration: BoxDecoration(
                  color: MainColor,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                ),
              ),
              //hospital name
              Container(
                margin: EdgeInsets.only(top: 15),
                child: Text('Cleopatra Hospital',style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,),),
              ),
              //hospital email
              Container(
                width: 320,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(Icons.mail,color: MainColor,),
                    ),
                    Text('cleopatrahospital@gmail.com',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  ],
                ),
              ),
              //Adress
              Container(
                width: 320,
                margin: EdgeInsets.only(top: 10),
                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(Icons.location_on,color: MainColor,size: 30,),
                    ),
                    Text('Egypt , Nasr City',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                  ],
                ),
              ),
              //phone and stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 10),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(right: 10),
                          child: Icon(Icons.phone_android,color: MainColor,size: 30,),
                        ),
                        Text('01017102408',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 17),),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    margin: EdgeInsets.only(top: 10,left: 5),
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,width: 1,style: BorderStyle.solid),
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.star,color: MainColor,),
                        Icon(Icons.star,color: MainColor,),
                        Icon(Icons.star,color: MainColor,),
                        Icon(Icons.star,color: MainColor,),
                      ],
                    ),
                  ),
                ],
              ),
              //hospital album
              Container(
                height: 200,
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    color: MainColor, borderRadius: BorderRadius.circular(20)),
                child: CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                    ),
                    items: _colors.map((i) {
                      return Builder(builder: (BuildContext context) {
                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(top: 25),
                          decoration: BoxDecoration(),
                          child: Column(
                            children: <Widget>[
                              Container(
                                decoration: BoxDecoration(
                                    color: MainColor,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Column(
                                  children: <Widget>[
                                    FractionallySizedBox(
                                      widthFactor: .92,
                                      child: Container(
                                        height: 150,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image(
                                            image: AssetImage(i['img']),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                    }).toList()),
              ),
              //hospital service
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20)
                ),
                child: Column(
                  children: <Widget>[
                    Text('Services',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    CarouselSlider(
                        options: CarouselOptions(height: 140,),
                        items: _colors.map((i){
                          return Builder(builder: (BuildContext context){
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(top: 25),
                              decoration: BoxDecoration(
                              ),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    width: 300,
                                    padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                        color: MainColor,
                                        borderRadius: BorderRadius.circular(20)
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                            margin: EdgeInsets.only(left: 30,right: 20),
                                            child: Icon(Icons.healing,size: 70,color: Colors.white,)
                                        ),
                                        Container(
                                          width: 3,
                                          margin: EdgeInsets.only(right: 20),
                                          height: 40,
                                          color: Colors.white,
                                        ),
                                        Text('healing',style: TextStyle(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),)
                                      ],
                                    ),
                                  ),

                                ],
                              ),
                            );
                          });
                        }).toList()),
                  ],
                ),
              ),
              //reviews
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 3,
                      color: MainColor,
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 350,
                        decoration: BoxDecoration(
                            color: MainColor,
                            borderRadius: BorderRadius.circular(20)
                        ),
                        child: Column(
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.only(top:10),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Text("Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        RaisedButton(
                                          color: Colors.white,
                                          onPressed: (){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => AdminViewReview()));
                                          },
                                          child: Text("View All",style: TextStyle(fontSize: 20,color: MainColor),),
                                        )

                                      ],
                                    ),
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
                                )
                            ),
                          ],
                        )
                    )
                  ],
                ),
              ),
            ],
          )
      ),
    );
  }
}

final List _colors=[
  {'name' : 'Cleopatra Hospital',
    'img':'assets/img/hospitals/cleopatra.jpg',
    'link':ViewHospital(),
  },
  {'name' : 'Eygption Hospital',
    'img':'assets/img/hospitals/eygptions.jpg',
    'link':ViewHospital(),
  },
  {'name' : '57357',
    'img':'assets/img/hospitals/75375.jpg',
    'link':ViewHospital(),
  },
  {'name' : '57357',
    'img':'assets/img/hospitals/eygptions.jpg',
    'link':ViewHospital(),
  }
];