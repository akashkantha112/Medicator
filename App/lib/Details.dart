
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

class Details extends StatefulWidget {
  final String diseaseName;

  Details(this.diseaseName);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  bool _isLoading;
  List<dynamic> symptoms;
  List<dynamic> causes;
  List<dynamic> remedies;
  List<dynamic> medication;
  String description;

  Future<void> getDetails() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("http://192.168.31.66:3000/getDetails"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"name": widget.diseaseName})));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    var result = jsonDecode(reply);

    setState(() {
      symptoms = result["symptoms"];
      causes = result["causes"];
      remedies = result["remedies"];
      medication = result["medication"];
      description = result["description"];
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;

    symptoms = causes = remedies = medication = [];

    getDetails();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            )),
        title: Text(capitalize(widget.diseaseName)),
      ),


      body: SingleChildScrollView(
        child: Container(
          child: _isLoading?Center(child: CircularProgressIndicator(),):Column(
            children: <Widget>[

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(description??""),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: Colors.white.withOpacity(0.6),),
              ),


              Text("Symptoms",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Wrap(
                    spacing: 4.0,
                    children: List.generate(symptoms.length, (int index){
                      return Chip(label: Text(symptoms[index]));
                    }),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: Colors.white.withOpacity(0.6),),
              ),


              Text("Causes",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Wrap(
                    spacing: 4.0,
                    children: List.generate(causes.length, (int index){
                      return Chip(label: Text(causes[index]));
                    }),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: Colors.white.withOpacity(0.6),),
              ),


              Text("Remedies",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Wrap(
                    spacing: 4.0,
                    children: List.generate(remedies.length, (int index){
                      return Chip(label: Text(remedies[index]));
                    }),
                  ),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Divider(color: Colors.white.withOpacity(0.6),),
              ),


              Text("Medication",style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,fontSize: 18.0),),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Wrap(
                    spacing: 4.0,
                    children: List.generate(medication.length, (int index){
                      return Chip(label: Text(medication[index]));
                    }),
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
