import 'package:flutter/material.dart';
import 'Reviews.dart';

Color w = Colors.white;
Color b = Colors.black;

class ViewReviews extends StatelessWidget{

  final List<Reviews> Rev = [
  Reviews(name: "Radwa" , Reviewws: "Wow"),
  Reviews(name: "Radwaa" , Reviewws: "Woow"),
  Reviews(name: "Radwaaa", Reviewws: "Wooow" ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('All Reviews', style: TextStyle(color: b, fontSize: 15,)),
        leading: GestureDetector(
          onTap: (){},
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 20,
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget> [
          Padding(padding: EdgeInsets.only(right: 15.0),
            child: GestureDetector(
              onTap: (){},
              child: Icon(Icons.exit_to_app),
            ) ,
          )
        ],
      ),

      body: Container(
        color: b,
        child: Column(
          children: <Widget>[
            ...Rev.map((e){
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),

                child: Row(
                  children: <Widget>[

                    Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: new BoxDecoration(
                            shape: BoxShape.circle,
                            image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage('assets/img/hospitals/cleopatra.jpg',),
                            )
                        )
                    ),
                    Container(

                   child : Column(
                        children: <Widget>[

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(e.name, style: TextStyle(color:Colors.blueAccent, fontSize: 20),),
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                                Icon(Icons.star),
                              ]
                          ),

                          Text(e.Reviewws, style: TextStyle(color:Colors.purpleAccent, fontSize: 20),textAlign: TextAlign.left,),
                          SizedBox(
                            height: 20,
                          ),

                        ]
                    ),
                    ),

                  ],
                ),
              );

            }).toList(),
          ],

        ),
      ),
    );

  }

}