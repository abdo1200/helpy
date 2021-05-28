import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';
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
              padding: EdgeInsets.symmetric(vertical: 25),
              decoration: BoxDecoration(
                color: Color.fromRGBO(28, 117, 201, 1),
                borderRadius: BorderRadius.only(
                    bottomLeft: const Radius.circular(60.0),
                    bottomRight: const Radius.circular(60.0)),
              ),
              child: Column(
                children: [
                  Row(
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
                  Container(
                    margin: EdgeInsets.only(top: 40.0),
                    child: CircleAvatar(
                      backgroundImage: AssetImage("assets/img/me.jpeg"),
                      radius: 50.0,
                    ),
                  ), //user image
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Text("Abdelrahman Sobhy",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 25,
                            fontWeight: FontWeight.bold)),
                  ), // user name
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: .95,
              child: Container(
                margin: const EdgeInsets.only(top: 25.0),
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
                      child: Text("abdosobhy1200@gmail.com",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20.0, right: 20),
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
                        child: Text("01017102408",
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
                            Icons.person,
                            color: Color.fromRGBO(28, 117, 201, 1),
                            size: 35,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25.0),
                        child: Text("male",
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
                    child: Text("Egypt, Cairo, Naser City",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        )),
                  ),
                ],
              ),
            ),
            FractionallySizedBox(
              widthFactor: .55,
              child: Container(
                margin: const EdgeInsets.only(top: 20.0),
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
                      child: Text("02/09/1999",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: .40,
              child: Container(
                margin: EdgeInsets.only(top: 25),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  color: Colors.red,
                  onPressed: () {

                  },
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.delete_forever,
                          color: Colors.white,
                        ),
                      ),
                      Text('Delete',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
