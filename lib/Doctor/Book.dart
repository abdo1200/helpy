import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:helpy/Auth/Login.dart';
import 'package:helpy/main.dart';

class Book extends StatefulWidget {
  @override
  _BookState createState() => _BookState();
}

class _BookState extends State<Book> {
  FirebaseAuth instance = FirebaseAuth.instance;
  var _selectedItems;
  int hour=8;
  int i;
  Color select=Colors.white;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Book Details",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            instance.signOut();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Login()));
          },
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.logout,
                size: 30.0,
              ),
              onPressed: () {}),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 300,
                width: 100,
                decoration: BoxDecoration(
                    border: Border.all(style: BorderStyle.solid,width: 1,color: MainColor),
                ),
                child: ListView.builder(
                  itemCount: 12,
                  itemBuilder: (context, index){
                    index=index+1;
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(style: BorderStyle.solid,width: 1,color: MainColor),
                        color: _selectedItems==index?MainColor:Colors.white
                      ),
                      child: ListTile(
                        title: Text('$index : 00',textAlign: TextAlign.center),
                        onTap: (){
                          setState(() {
                            _selectedItems=index;
                          });
                        },
                      ),
                    );
                  },
                ),
              ),
              RaisedButton(
                child: Text('Book',style: TextStyle(color: Colors.white),),
                color: Colors.red,
                onPressed: (){},
              )

            ],
          ),
        ),
      ),
    );
  }
}
