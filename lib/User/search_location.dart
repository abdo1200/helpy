import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Hospital/ViewHospital.dart';
import 'package:helpy/main.dart';
import 'search_name.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchLocation extends StatefulWidget {
  @override
  _SearchLocationState createState() => _SearchLocationState();
}

class _SearchLocationState extends State<SearchLocation> {

  String dropdownValue = 'Select Area';
  void select(BuildContext ctx) {
    Navigator.of(ctx).push(MaterialPageRoute(builder: (_) {
      return SearchName();
    }));
  }
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Location Search'),
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
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(height: 25),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: MainColor,style: BorderStyle.solid,width: 3),
                  borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
                ),
                margin: EdgeInsets.all(15),
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: dropdownValue,
                  icon: const Icon(Icons.arrow_drop_down_circle,color: MainColor,size: 30,),
                  iconSize: 24,
                  elevation: 16,
                  style: new TextStyle(inherit: false, color: MainColor, decorationColor: Colors.white,fontSize: 20),
                  underline: Container(
                    height: 0,
                    color: MainColor,
                  ),
                  onChanged: (newValue) {
                    setState(() {
                      dropdownValue = newValue;
                    });
                  },
                  items: <String>['Select Area', '6 October', 'cairo']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                )
              ),
              SizedBox(height: 25),
              Text(
                "Search Results",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.blueAccent),
              ),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Hospitals').where('address',isEqualTo: dropdownValue)
                      .limit(3).orderBy('Rate',descending: true).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if(snapshot.data.docs.isNotEmpty){
                      return new Column(
                        children: snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data();
                          return Card(
                            margin: EdgeInsets.all(30),
                            clipBehavior: Clip.antiAlias,
                            elevation: 16,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (context) => ViewHospital(document.id)));
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Ink.image(
                                        image: NetworkImage(data['imageurl']),
                                        height: 150,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                         top: 15, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${data['name']}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            for(int i=0;i<data['Rate'];i++)
                                              Icon(Icons.star,
                                                  color: Colors.blueAccent, size: 25.0),

                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                        }).toList(),
                      );}else{
                      return Container(
                        margin: EdgeInsets.only(top: 100),
                        child: Text("No Hospitals",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                      );
                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
