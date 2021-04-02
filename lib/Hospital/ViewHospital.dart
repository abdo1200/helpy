import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:helpy/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ViewHospital extends StatefulWidget {
  @override
  _ViewHospitalState createState() => _ViewHospitalState();
}

class _ViewHospitalState extends State<ViewHospital> {
  FirebaseAuth instance = FirebaseAuth.instance;
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
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => UserHome()));
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
                  color: MainColor,
                  borderRadius: BorderRadius.circular(20)
                ),
                child: CarouselSlider(
                    options: CarouselOptions(height: 200,),
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
                                decoration: BoxDecoration(
                                    color: MainColor,
                                    borderRadius: BorderRadius.circular(30)
                                ),
                                child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 150,
                                        width: 320,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(30),
                                          child: Image(
                                            image: AssetImage(i['img']),
                                            fit: BoxFit.cover,
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
              //add review
              Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      width: 250,
                      height: 3,
                      color: MainColor,
                      margin: EdgeInsets.only(bottom: 30),
                    ),
                    Text('Add Review',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    Container(
                      width: 350,
                      margin: EdgeInsets.only(top: 20),
                      child: TextField(
                        // onChanged: (value) {
                        //   setState(() {
                        //     this._password = value;
                        //   });
                        // },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            focusColor: Colors.blue,
                            fillColor: Colors.red,
                            hintText: 'Add Your Review',
                        ),
                      ),
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
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text("Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                RaisedButton(
                                  color: Colors.white,
                                  onPressed: (){},
                                  child: Text("View All",style: TextStyle(fontSize: 20,color: MainColor),),
                                )

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
