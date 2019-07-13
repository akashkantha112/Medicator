import 'package:ciem_hackathon/Details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class Prediction extends StatefulWidget {
  List<dynamic> diseases;

  Prediction(this.diseases);

  @override
  _PredictionState createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text("Predictions"),
      ),
      body: widget.diseases.length == 0
          ? Container(
              child: Center(
                child: Text("Some error occured"),
              ),
            )
          : Container(
              child: ListView.builder(
                itemCount: widget.diseases.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageTransition(
                              child: Details(
                                  widget.diseases[index]["name"].toLowerCase()),
                              type: PageTransitionType.downToUp));
                    },
                    title: Text(widget.diseases[index]["name"]),
                    subtitle: Text(widget.diseases[index]["chance"].toString()),
                  );
                },
              ),
            ),
    );
  }
}
