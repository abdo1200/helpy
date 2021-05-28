import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchName extends StatefulWidget {
  @override
  _SearchNameState createState() => _SearchNameState();
}

class _SearchNameState extends State<SearchName> {
  FirebaseAuth instance = FirebaseAuth.instance;
  String name= 'Hosptial name';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: MainColor,
        title: Text('Name Search'),
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
                margin: EdgeInsets.all(15),
                child: TextField(
                  onChanged: (value) {
                  setState(() {
                  name = value.toUpperCase();
                  if(name==''){
                    name='Hosptial name';
                  }
                  });},
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                      left: 25.0,
                    ),
                    hintText: "Hospital Name",
                    hintStyle: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                      borderSide: BorderSide(
                        color: Colors.blueAccent,
                        width: 2.0,
                      ),
                    ),
                    suffixIcon: Container(
                      decoration: BoxDecoration(
                        color: MainColor,
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  ),
                ),
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
                height: 400,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('Hospitals').where('name',
                    isGreaterThanOrEqualTo: name,
                    isLessThan: name.substring(0, name.length - 1) +
                        String.fromCharCode(name.codeUnitAt(name.length - 1) + 1),).snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    if(snapshot.data.docs.isNotEmpty){
                      print(name);
                      return new ListView(
                        children: snapshot.data.docs.map((DocumentSnapshot document) {
                          Map<String, dynamic> data = document.data();
                          return Card(
                            margin: EdgeInsets.all(30),
                            clipBehavior: Clip.antiAlias,
                            elevation: 16,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            child: InkWell(
                              onTap: () {},
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Stack(
                                    alignment: Alignment.bottomLeft,
                                    children: [
                                      Ink.image(
                                        image: AssetImage("assets/img/hospitals/75375.jpg"),
                                        height: 150,
                                        fit: BoxFit.fitWidth,
                                      ),
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 50, top: 15, right: 50, bottom: 30),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          '${data['name']}',
                                          style: TextStyle(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 23),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            for(int i=0;i<data['rate'];i++)
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
// SingleChildScrollView(
// child: Column(
// mainAxisAlignment: MainAxisAlignment.center,
// crossAxisAlignment: CrossAxisAlignment.start,
// children: <Widget>[
// Container(
// child: TextFormField(
// key: _formKey,
// decoration: InputDecoration(
// border: OutlineInputBorder(),
// focusColor: Colors.blue,
// fillColor: Colors.red,
// hintText: 'hospital name..',
// ),
// onChanged: (value) {
// setState(() {
// name = value.toUpperCase();
// });
// },
// ),
// ),
// Container(
// height: 400,
// child: StreamBuilder<QuerySnapshot>(
// stream: FirebaseFirestore.instance
//     .collection('hospitals')
// .where('name', isEqualTo: name)
// .snapshots(),
// builder: (BuildContext context,
//     AsyncSnapshot<QuerySnapshot> snapshot) {
// if (snapshot.hasError) {
// return Text('Something went wrong!');
// }
// if (snapshot.connectionState ==
// ConnectionState.waiting) {
// return Text('Loading..');
// }
// if (snapshot.data!.docs.isNotEmpty) {
// return new ListView(
// children: snapshot.data!.docs
//     .map((DocumentSnapshot document) {
// return Container(
// alignment: Alignment.center,
// margin: EdgeInsets.only(top: 20),
// width: 100,
// height: 100,
// color: Colors.blue,
// child: Text(
// "${document['name']}",
// style: TextStyle(
// color: Colors.white,
// fontWeight: FontWeight.bold,
// fontSize: 20),
// ),
// );
// }).toList(),
// );
// } else {
// return Text("No Hospitals");
// }
// }),
// ),
// ],
// ),
// ),