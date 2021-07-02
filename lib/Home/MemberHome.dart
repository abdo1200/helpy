import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Articals/Artical.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Doctor/doctor.dart';
import 'package:helpy/Hospital/ViewHospital.dart';
import 'package:helpy/User/search_location.dart';
import 'package:helpy/User/search_name.dart';
import 'package:helpy/User/user_profile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../main.dart';

class MemberHome extends StatefulWidget {
  @override
  _MebmerHomeState createState() => _MebmerHomeState();
}

class _MebmerHomeState extends State<MemberHome>{
  FirebaseAuth instance = FirebaseAuth.instance;
  final firestoreInstance = FirebaseFirestore.instance;
  List colors=[];

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
                      // navbar
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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

                      //profile and doctors
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Doctor()));
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
                                    child: Icon(Icons.medical_services_rounded,color: MainColor,size: 40,),
                                  ),
                                  Container(
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text("Doctors",style: TextStyle(color: MainColor,fontSize: 18,fontWeight: FontWeight.bold),)
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
                                      padding: EdgeInsets.only(top: 5),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
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
                    ],
                  ),
                ),

                // top hospital
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
                        child:
                        StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('Hospitals').limit(3).snapshots(),
                          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return Text('Something went wrong');
                            }

                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("Loading");
                            }
                            snapshot.data.docs.forEach((element) {
                              colors.add({
                                'name':element['name'],
                                'img':element['imageurl'],
                                'id' : element.id.toString()
                              });
                            });
                            return Container(
                              child: CarouselSlider(
                                  options: CarouselOptions(height: 200,),
                                  items: colors.map((i){
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
                                                          builder: (context) => ViewHospital(i['id'])));
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
                                                            image: NetworkImage(i['img']),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20,top: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(bottom: 20),
                        child: Text(
                          "Latest Articles",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      SizedBox(
                          height: 298, // card height
                          child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance.collection('Articles').limit(5).snapshots(),
                            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                              if(snapshot.data == null) return CircularProgressIndicator();
                              return PageView.builder(
                                itemCount: 5,
                                controller: PageController(viewportFraction: 0.9),
                                itemBuilder: (_, i) {
                                  String id=snapshot.data.docs[i].id;
                                  return Transform.scale(
                                    scale: 0.98,
                                    child: Card(
                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                      child: Center(
                                        child: InkWell(
                                          onTap: () {
                                            Navigator.push(
                                                context, MaterialPageRoute(builder: (context) => Artical(id)));
                                          },
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Stack(
                                                alignment: Alignment.bottomLeft,
                                                children: [
                                                  Container(
                                                    height: 190,
                                                    decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.circular(10),
                                                        image: DecorationImage(
                                                          image: NetworkImage(snapshot.data.docs[i].data()['image']),
                                                          fit: BoxFit.cover,
                                                        )
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10, right: 15,left: 20,bottom: 10),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    Text(
                                                      snapshot.data.docs[i].data()['date'],
                                                      style: TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 15),
                                                    ),
                                                    SizedBox(
                                                      height: 15,
                                                    ),
                                                    Text(
                                                      snapshot.data.docs[i].data()['Title'],
                                                      style: TextStyle(
                                                          color: Colors.blueAccent,
                                                          fontWeight: FontWeight.bold,
                                                          fontSize: 20,
                                                          height: 1
                                                      ),textAlign:TextAlign.end,
                                                    ),

                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        // child: Text(
                                        //   "Card ${i + 1}",
                                        //   style: TextStyle(fontSize: 32),
                                        // ),
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          )

                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}


