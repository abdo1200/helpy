import 'package:flutter/material.dart';
import 'package:helpy/Home/StartedPage.dart';
import 'package:helpy/Home/UserHome.dart';

void main() => runApp(MyApp());

const MainColor= Color(0xff2E75BE);
class MyApp extends StatelessWidget {
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
      home: StartedPage(),
    );
  }
}

