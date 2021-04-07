import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Auth/Login.dart';
class DeleteUser extends StatefulWidget {
  @override
  _DeleteUserState createState() => _DeleteUserState();
}

class _DeleteUserState extends State<DeleteUser> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              // background
              width: double.infinity,
              padding: EdgeInsets.all(25.0),
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 117, 201, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(60.0),
                    bottomRight: const Radius.circular(60.0)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 180),
                        child: FlatButton(
                            child: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                                size: 30,
                              ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Container(
                        alignment: AlignmentDirectional.topEnd,
                        child: FlatButton(
                            child: IconButton(
                              icon: Icon(
                                Icons.exit_to_app,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                            onPressed: () {
                              instance.signOut();
                              Navigator.pushReplacement(
                                  context, MaterialPageRoute(builder: (context) => Login()));
                            }),
                      ),
                    ],
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("images/asmaa.png"),
                      radius: 50.0,
                    ),
                  ), //user image
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text("Asmaa Mahmoud",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ), // user name
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25.0, left: 30, right: 30),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 25.0,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.email,
                        color: Color.fromRGBO(28, 117, 201, 1),
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Text("asmaa329917@gmail.com",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, left: 35, right: 20),
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(
                          left: 5.0,
                        ),
                        child: IconButton(
                          icon: Icon(
                            Icons.phone_android,
                            color: Color.fromRGBO(28, 117, 201, 1),
                            size: 30,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 10.0),
                        child: Text("01140862754",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  padding: EdgeInsets.all(2.0),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Row(
                    children: [
                      Container(
                        child: IconButton(
                          icon: Icon(
                            Icons.pregnant_woman,
                            color: Color.fromRGBO(28, 117, 201, 1),
                            size: 35,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Text("Female",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20.0, left: 35.0, right: 35.0),
              padding: EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.add_location,
                        color: Color.fromRGBO(28, 117, 201, 1),
                        size: 35,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5.0),
                    child: Text("Egypt, Cairo, ElSayeda Zeinab",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 100, right: 100, top: 20.0),
              padding: EdgeInsets.all(2.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(50),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(
                      left: 20.0,
                    ),
                    child: IconButton(
                      icon: Icon(
                        Icons.calendar_today,
                        color: Color.fromRGBO(28, 117, 201, 1),
                        size: 30,
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text("03/02/1999",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 25, left: 140, right: 130),
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                color: Color.fromRGBO(28, 117, 201, 1),
                onPressed: () {

                },
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    Text('Delete',
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
