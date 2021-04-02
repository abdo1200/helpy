import 'package:flutter/material.dart';
import 'package:helpy/Home/StartedPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:helpy/Home/UserHome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Home/home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

const MainColor= Color(0xff2E75BE);
class MyApp extends StatelessWidget {
  FirebaseAuth instance = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        backgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Home(),
    );
  }
}

