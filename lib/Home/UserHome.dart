import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Hospital/ViewHospital.dart';
import 'package:helpy/User/search_location.dart';
import 'package:helpy/User/search_name.dart';
import 'package:helpy/User/user_profile.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserHome extends StatefulWidget {
  @override
  _UserHomeState createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  FirebaseAuth instance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          color: MainColor,
          child: Column(
            children: <Widget>[
              Container(
                alignment: Alignment.bottomCenter,
                height: 430,
                width: 412,
                child: Column(
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("HELPY",style: TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                          Container(
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: 50,
                                  height: 50,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: AssetImage('assets/img/me.jpeg'),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.exit_to_app),
                                  color: Colors.white,
                                  onPressed: (){
                                  instance.signOut();
                                  Navigator.pushReplacement(
                                      context, MaterialPageRoute(builder: (context) => Login()));
                                },)
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    // user location
                    FractionallySizedBox(
                      widthFactor: .95,
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 10,bottom: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.only(left: 40,top: 15),
                              child: Text("Your Location :",style: TextStyle(color: MainColor,fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 35,top: 15),
                              child: Row(
                                children: <Widget>[
                                  Icon(Icons.location_on,color: MainColor,size: 30,),
                                  Text(" Nasr City",style: TextStyle(color: MainColor,fontSize: 20,fontWeight: FontWeight.bold),)
                                ],
                              )
                            ),
                          ],
                        ),
                      ),
                    ),
                    // search location and name
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchLocation()));
                          },
                          child: Container(
                            width: 160,
                            height: 100,
                            margin: EdgeInsets.only(left: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Icon(Icons.location_on,color: MainColor,size: 40,),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 15,top: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Nearest Hospital",style: TextStyle(color: MainColor,fontSize: 18,fontWeight: FontWeight.bold),)
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SearchName()));
                          },
                          child: Container(
                            width: 160,
                            height: 100,
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white,
                            ),
                            child: Column(
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  child: Icon(Icons.search,color: MainColor,size: 40,),
                                ),
                                Container(
                                    padding: EdgeInsets.only(left: 20,top: 5),
                                    child: Row(
                                      children: <Widget>[
                                        Text("Search Hospital",style: TextStyle(color: MainColor,fontSize: 18,fontWeight: FontWeight.bold),)
                                      ],
                                    )
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserProfile()));
                      },
                      child: Container(
                          width: 160,
                          height: 100,
                          margin: EdgeInsets.only(top: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                padding: EdgeInsets.only(top: 15),
                                child: Icon(Icons.person,color: MainColor,size: 40,),
                              ),
                              Container(
                                  padding: EdgeInsets.only(left: 55,top: 5),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Profile",style: TextStyle(color: MainColor,fontSize: 18,fontWeight: FontWeight.bold),)
                                    ],
                                  )
                              ),
                            ],
                          ),
                        ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                height: 314,
                width: 412,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/img/userback.png'),
                    fit: BoxFit.cover
                  )
                ),
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 50,bottom: 30,left: 20),
                      child: Text('Top Hospitals',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ),
                    Container(
                      child: CarouselSlider(
                          options: CarouselOptions(height: 200,),
                          items: _colors.map((i){
                            return Builder(builder: (BuildContext context){
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                ),
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      decoration: BoxDecoration(
                                        color: MainColor,
                                        borderRadius: BorderRadius.circular(30)
                                      ),
                                      child: InkWell(
                                        onTap: (){
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => i['link']));
                                        },
                                        child: Column(
                                          children: <Widget>[
                                            FractionallySizedBox(
                                              widthFactor: .95,
                                              child: Container(
                                                height: 100,
                                                child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(30),
                                                  child: Image(
                                                    image: AssetImage(i['img']),
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(vertical:10),
                                              child: Text(i['name'],style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.white),),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  ],
                                ),
                              );
                            });
                          }).toList()),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )
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
  }
];