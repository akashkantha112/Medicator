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
  
  String predictionString = "Predictions";
  String errorString = "Some error occured";
  
  String diseaseName = "name";
  String diseaseProbability = "chance";
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(predictionString),
      ),
      body: widget.diseases.length == 0
          ? Container(
              child: Center(
                child: Text(errorString),
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
                                  widget.diseases[index][diseaseName].toLowerCase()),
                              type: PageTransitionType.downToUp));
                    },
                    title: Text(widget.diseases[index][diseaseName]),
                    subtitle: Text(widget.diseases[index][diseaseProbability].toString()),
                  );
                },
              ),
            ),
    );
  }
}
