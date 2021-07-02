import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/Doctor/doctor_profile.dart';
import '../main.dart';

class DoctorHome extends StatefulWidget {
  @override
  _DoctorHomeState createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  FirebaseAuth instance = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img/loginback.png'),
                    fit: BoxFit.cover)
            ),
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 30,horizontal: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
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
                      Container(
                        margin: EdgeInsets.only(top: 50,right: 20),
                        child: Column(
                          children: <Widget>[
                            ButtonContainer(
                              buttonText: "Messegs",
                              buttonIcon: Icons.chat,
                              //widgetName: AddHospital(),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            ButtonContainer(
                              buttonText: "Reservations",
                              buttonIcon: Icons.shopping_bag_rounded,
                              //widgetName: AdminViewHospitals(),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                            ButtonContainer(
                              buttonText: "Profile",
                              buttonIcon: Icons.person,
                              widgetName: DoctorProfile(instance.currentUser.email),
                            ),
                            SizedBox(
                              height: 45,
                            ),
                          ],
                        ),
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
          color: MainColor,
          borderRadius: BorderRadius.circular(25),
        ),
        width: 170,
        height: 100,
        child: Center(
          child: Column(
            children: <Widget>[
              Icon(
                buttonIcon,
                color: Colors.white,
                size: 40,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                buttonText,
                style: TextStyle(
                    color: Colors.white,
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