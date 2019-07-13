import 'package:ciem_hackathon/AddSymptoms.dart';
import 'package:ciem_hackathon/SearchDisease.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          color: Colors.black,
      child: Column(
        children: <Widget>[
          SizedBox(
            height: MediaQuery.of(context).size.height * .65,
            child: Container(
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage("assets/logo.jpg"),fit: BoxFit.cover)),
            ),
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {Navigator.push(context, PageTransition(child: new AddSymptoms(), type: PageTransitionType.downToUp));},
                child: Text(
                  "Enter Symptoms",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * .75,
              child: RaisedButton(
                color: Colors.white,
                onPressed: () {Navigator.push(context, PageTransition(child: new SearchDisease(), type: PageTransitionType.downToUp));},
                child: Text(
                  "Search Disease",
                  style: TextStyle(color: Colors.black, fontSize: 20.0),
                ),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
