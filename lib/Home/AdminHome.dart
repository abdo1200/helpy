import 'package:flutter/material.dart';
import 'package:helpy/Articals/AddArticle.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Hospital/AdminViewHospitals.dart';
import 'package:helpy/Hospital/add_hospital.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/User/ViewUsers.dart';


class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blue[800],
        body: SingleChildScrollView(
          child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          'Home',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Colors.white),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          instance.signOut();
                          Navigator.pushReplacement(
                              context, MaterialPageRoute(builder: (context) => Login()));
                        },
                        icon: Icon(
                          Icons.exit_to_app,
                          color: Colors.white,
                          size: 25,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Center(
                  heightFactor: 1.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ButtonContainer(
                        buttonText: "Add Hospital",
                        buttonIcon: Icons.local_hospital,
                        widgetName: AddHospital(),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      ButtonContainer(
                        buttonText: "View Hospitals",
                        buttonIcon: Icons.airline_seat_flat_angled,
                        widgetName: AdminViewHospitals(),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      ButtonContainer(
                        buttonText: "View Users",
                        buttonIcon: Icons.people,
                        widgetName: ViewUsers(),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      ButtonContainer(
                        buttonText: "Add Artical",
                        buttonIcon: Icons.article,
                        widgetName: AddArticle(),
                      ),
                    ],
                  ),
                ),
              ]
          ),
        )
    );
  }
}

class ButtonContainer extends StatelessWidget {
  final String buttonText;
  final IconData buttonIcon;
  final Widget widgetName;
  const ButtonContainer({
    @required this.buttonText,
    @required this.buttonIcon,
    @required this.widgetName,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => widgetName != null
          ? Navigator.push(
          context, MaterialPageRoute(builder: (context) => widgetName))
          : null,
      child: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        width: 250,
        height: 100,
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                buttonIcon,
                color: Colors.blue[800],
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                buttonText,
                style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}