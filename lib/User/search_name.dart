import 'package:flutter/material.dart';

class SearchName extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Rest of your Code
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Hospital name search",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
        ),
        leading: new IconButton(
          icon: new Icon(
            Icons.arrow_back,
            size: 30.0,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: <Widget>[
          new IconButton(
              icon: new Icon(
                Icons.exit_to_app,
                size: 30.0,
              ),
              onPressed: () {}),
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
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
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
                    suffixIcon: Icon(
                      Icons.search,
                      color: Colors.blueAccent,
                      size: 60.0,
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
