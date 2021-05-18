import 'package:flutter/material.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchName extends StatelessWidget {
  FirebaseAuth instance = FirebaseAuth.instance;
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
              Card(
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
                              "Hospital Name",
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 23),
                            ),

                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.star, color: Colors.blueAccent, size: 25.0),
                                Icon(Icons.star, color: Colors.blueAccent, size: 25.0),
                                Icon(Icons.star, color: Colors.blueAccent, size: 25.0),
                                Icon(Icons.star, color: Colors.blueAccent, size: 25.0),
                                Icon(Icons.star, color: Colors.blueAccent, size: 25.0),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
