import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:helpy/Hospital/ViewHospital.dart';
import 'package:helpy/Reviews/AdminViewReview.dart';
import 'package:helpy/Reviews/Reviews.dart';
import 'package:helpy/Reviews/ViewReviews.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';


class AdminViewSpecificHospital extends StatefulWidget {
  String id;
  AdminViewSpecificHospital(this.id);
  @override
  _AdminViewSpecificHospitalState createState() => _AdminViewSpecificHospitalState();
}

class _AdminViewSpecificHospitalState extends State<AdminViewSpecificHospital> {
  FirebaseAuth instance = FirebaseAuth.instance;
  CollectionReference Reviews=FirebaseFirestore.instance.collection('Reviews');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Hospitals').doc(widget.id).snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const Text('loading');
            return Column(
              children: <Widget>[
                // image
                Container(
                  width: double.infinity,
                  height: 250,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(snapshot.data['imageurl']),
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
                            Navigator.pop(context);
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
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.only(top: 15,right: 25),
                  child: Text(
                    snapshot.data['name'],
                    style: TextStyle(
                      fontSize: 27,
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
                        snapshot.data['email'],
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
                        snapshot.data['address'],
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
                            snapshot.data['phone'],
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
                          for(int i=0;i<snapshot.data['Rate'];i++)
                            Icon(
                              Icons.star,
                              color: MainColor,
                            ),
                        ],
                      ),
                    ),
                  ],
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
                            itemCount: snapshot.data['service'].length,
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
                                          spreadRadius: 3,
                                          blurRadius: 7,
                                          offset: Offset(0, 3), // changes position of shadow
                                        ),
                                      ],
                                      color: MainColor
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(snapshot.data['service'][index],style: TextStyle(fontSize: 18,color: Colors.white))
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
                          margin: EdgeInsets.only(top: 20,bottom: 20),
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
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white
                                        ),
                                      ),
                                      RaisedButton(
                                        color: Colors.white,
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      AdminViewReview(widget.id)));
                                        },
                                        child: Text(
                                          "View All",
                                          style: TextStyle(
                                              fontSize: 20, color: MainColor),
                                        ),
                                      )
                                    ],
                                  )),
                              Container(
                                padding: EdgeInsets.only(bottom: 20),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance.collection('Reviews').where('hospid',isEqualTo: widget.id).limit(3).snapshots(),
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
                                          child: Text("No Reviews",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                                        );
                                      }
                                    }
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

final List _colors=[
  {'name' : 'Cleopatra Hospital',
    'img':'assets/img/hospitals/cleopatra.jpg',

  },
  {'name' : 'Eygption Hospital',
    'img':'assets/img/hospitals/eygptions.jpg',

  },
  {'name' : '57357',
    'img':'assets/img/hospitals/75375.jpg',
  },
  {'name' : '57357',
    'img':'assets/img/hospitals/eygptions.jpg',

  }
];

