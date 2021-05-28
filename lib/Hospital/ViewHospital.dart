import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:helpy/Reviews/ViewReviews.dart';
import 'package:helpy/main.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Reviews/Reviews.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class ViewHospital extends StatefulWidget {
  @override
  _ViewHospitalState createState() => _ViewHospitalState();
}

class _ViewHospitalState extends State<ViewHospital> {
  FirebaseAuth instance = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference documents =
      FirebaseFirestore.instance.collection('Reviews');
  String Comment = "null";
  int Rate = 0;
  var Y=Colors.yellow;
  var DefaultColor1 = Colors.white;
  var DefaultColor2 = Colors.white;
  var DefaultColor3 = Colors.white;
  var DefaultColor4 = Colors.white;
  var DefaultColor5 = Colors.white;

  Future<void> addReview() {
    // Call the user's CollectionReference to add a new user
    return documents
        .add({'comment': Comment, 'rate': Rate})
        .then((value) => print("Review Added Successfully"))
        .catchError((error) => print("Failed to add Review: $error"));
  }

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
                    fit: BoxFit.cover)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: 5, left: 5),
                  decoration: BoxDecoration(
                      color: MainColor,
                      borderRadius: BorderRadius.circular(60)),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => UserHome()));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 5, right: 5),
                  decoration: BoxDecoration(
                      color: MainColor,
                      borderRadius: BorderRadius.circular(60)),
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.exit_to_app),
                    onPressed: () {
                      instance.signOut();
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) => Login()));
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
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
          ),
          //hospital name
          Container(
            margin: EdgeInsets.only(top: 15),
            child: Text(
              'Cleopatra Hospital',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //hospital email
          Container(
            width: 320,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.mail,
                    color: MainColor,
                  ),
                ),
                Text(
                  'cleopatrahospital@gmail.com',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
              ],
            ),
          ),
          //Adress
          Container(
            width: 320,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.grey, width: 1, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.location_on,
                    color: MainColor,
                    size: 30,
                  ),
                ),
                Text(
                  'Egypt , Nasr City',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                ),
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
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Icon(
                        Icons.phone_android,
                        color: MainColor,
                        size: 30,
                      ),
                    ),
                    Text(
                      '01017102408',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                  ],
                ),
              ),
              Container(
                width: 150,
                margin: EdgeInsets.only(top: 10, left: 5),
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Colors.grey, width: 1, style: BorderStyle.solid),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.star,
                      color: MainColor,
                    ),
                    Icon(
                      Icons.star,
                      color: MainColor,
                    ),
                    Icon(
                      Icons.star,
                      color: MainColor,
                    ),
                    Icon(
                      Icons.star,
                      color: MainColor,
                    ),
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
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
            child: Column(
              children: <Widget>[
                Text(
                  'Services',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  width: double.infinity,
                  child: StaggeredGridView.countBuilder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    itemCount: 8,
                    itemBuilder: (BuildContext context, int index) => new FractionallySizedBox(
                      child: Container(
                          margin: EdgeInsets.only(bottom: 20),
                          padding: EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                          decoration: BoxDecoration(
                            border: Border.all(color: MainColor,width: 1,style: BorderStyle.solid),
                            borderRadius: BorderRadius.circular(40),
                            boxShadow: [
                              BoxShadow(
                                color: MainColor.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // changes position of shadow
                              ),
                            ],
                            color: MainColor
                          ),
                          child: Row(
                            children: [
                              SizedBox(width: 10,),
                              Text('# ',style: TextStyle(color: Colors.white,fontSize: 18),),
                              Text(' Healing',style: TextStyle(fontSize: 18,color: Colors.white))
                            ],
                          )
                      ),
                    ),
                    staggeredTileBuilder: (int index) =>
                    new StaggeredTile.count(2, .7),
                    mainAxisSpacing: 4.0,
                    crossAxisSpacing: 5.0,
                  )
                ),
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
                Text(
                  'Add Review',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: 350,
                  margin: EdgeInsets.only(top: 20),
                  child: TextField(
                    onChanged: (value) {
                      Comment = value;
                    },
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
                  width: 270,
                  decoration: BoxDecoration(
                      color: MainColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.star, color: DefaultColor1),
                        onPressed: () {
                          setState(() {
                            Rate = 1;
                            DefaultColor1 = Y;
                            DefaultColor2 = Colors.white;
                            DefaultColor3 = Colors.white;
                            DefaultColor4 = Colors.white;
                            DefaultColor5 = Colors.white;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.star, color: DefaultColor2),
                        onPressed: () {
                          setState(() {
                            Rate = 2;
                            DefaultColor1 = Y;
                            DefaultColor2 = Y;
                            DefaultColor3 = Colors.white;
                            DefaultColor4 = Colors.white;
                            DefaultColor5 = Colors.white;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.star, color: DefaultColor3),
                        onPressed: () {
                          setState(() {
                            Rate = 3;
                            DefaultColor1 = Y;
                            DefaultColor2 = Y;
                            DefaultColor3 = Y;
                            DefaultColor4 = Colors.white;
                            DefaultColor5 = Colors.white;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.star, color: DefaultColor4),
                        onPressed: () {
                          setState(() {
                            Rate = 4;
                            DefaultColor1 = Y;
                            DefaultColor2 = Y;
                            DefaultColor3 = Y;
                            DefaultColor4 = Y;
                            DefaultColor5 = Colors.white;
                          });
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.star, color: DefaultColor5),
                        onPressed: () {
                          setState(() {
                            Rate = 5;
                            DefaultColor1 = Y;
                            DefaultColor2 = Y;
                            DefaultColor3 = Y;
                            DefaultColor4 = Y;
                            DefaultColor5 = Y;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(20),
                  child: RaisedButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      child: Text("Submit",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      color: MainColor,
                      onPressed: () async {
                        addReview();
                      }),
                ),
                Container(
                    margin: EdgeInsets.only(top: 20),
                    width: 350,
                    decoration: BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "Reviews",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                RaisedButton(
                                  color: Colors.white,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ViewReviews()));
                                  },
                                  child: Text(
                                    "View All",
                                    style: TextStyle(
                                        fontSize: 20, color: MainColor),
                                  ),
                                )
                              ],
                            )),
                        ...Rev.map((e) {
                          return Container(
                            margin: EdgeInsets.only(bottom: 5),
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Row(
                                    children: [
                                      Container(
                                          width: 50.0,
                                          height: 50.0,
                                          margin: EdgeInsets.only(left: 10),
                                          decoration: new BoxDecoration(
                                              shape: BoxShape.circle,
                                              image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: AssetImage(
                                                  'assets/img/hospitals/cleopatra.jpg',
                                                ),
                                              ))),
                                      Container(
                                        margin: EdgeInsets.only(left: 20),
                                        child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              Text(
                                                e.name,
                                                style: TextStyle(
                                                    color: MainColor,
                                                    fontSize: 17,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                e.Reviewws,
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15),
                                                textAlign: TextAlign.left,
                                              ),
                                              Row(children: <Widget>[
                                                Icon(
                                                  Icons.star,
                                                  color: MainColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: MainColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: MainColor,
                                                ),
                                                Icon(
                                                  Icons.star,
                                                  color: MainColor,
                                                ),
                                              ]),
                                            ]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ))
              ],
            ),
          ),
        ],
      )),
    );
  }
}

final List _colors = [
  {
    'name': 'Cleopatra Hospital',
    'img': 'assets/img/hospitals/cleopatra.jpg',
    'link': ViewHospital(),
  },
  {
    'name': 'Eygption Hospital',
    'img': 'assets/img/hospitals/eygptions.jpg',
    'link': ViewHospital(),
  },
  {
    'name': '57357',
    'img': 'assets/img/hospitals/75375.jpg',
    'link': ViewHospital(),
  },
  {
    'name': '57357',
    'img': 'assets/img/hospitals/eygptions.jpg',
    'link': ViewHospital(),
  }
];
final List<Reviews> Rev = [
  Reviews(name: "Radwa", Reviewws: "it's good hospital"),
  Reviews(name: "Radwaa", Reviewws: "it's good hospital"),
  Reviews(name: "Radwaaa", Reviewws: "it's good hospital"),
];
