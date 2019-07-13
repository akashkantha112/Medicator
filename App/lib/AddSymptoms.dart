import 'dart:convert';
import 'dart:io';
import 'package:ciem_hackathon/Result.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class AddSymptoms extends StatefulWidget {
  @override
  _AddSymptomsState createState() => _AddSymptomsState();
}

class _AddSymptomsState extends State<AddSymptoms> {
  List<dynamic> symptoms;
  TextEditingController _textEditingController;

  Future<List<dynamic>> getDetails(query) async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
        .postUrl(Uri.parse("http://192.168.31.66:3000/searchSymptom"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"query": query})));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    print(reply);

    var result = jsonDecode(reply);

    print(result);

    return result["res"] ?? [];
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  @override
  void initState() {
    super.initState();
    symptoms = [];
  }


  Future<void> getPredictions() async {
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient
      .postUrl(Uri.parse("http://192.168.31.66:3000/getDisease"));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode({"symptoms": symptoms})));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();

    var result = jsonDecode(reply);

    Navigator.push(context,PageTransition(child: Prediction(result), type: PageTransitionType.downToUp));


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
        title: Text("Disease Predictor"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TypeAheadField(
                noItemsFoundBuilder: (BuildContext context){
                  return ListTile(title: Text("No matches found!"));
                },
                textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
                    decoration:
                        InputDecoration(border: UnderlineInputBorder())),
                suggestionsCallback: (pattern) async {
                  return await getDetails(pattern);
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(
                      capitalize(suggestion),
                      style: TextStyle(fontStyle: FontStyle.italic),
                    ),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    symptoms.add(suggestion);
                  });
                },
              ),
            ),
            Flexible(
              child: Container(
                child: ListView.builder(
                  itemCount: symptoms.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(capitalize(symptoms[index])),
                      trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () {
                            setState(() {
                              symptoms.removeAt(index);
                            });
                          }),
                    );
                  },
                ),
              ),
            ),
            symptoms.length == 0 ? SizedBox(height: 0.0,):Container(
              margin: EdgeInsets.zero,
              height: 50.0,
              width: MediaQuery.of(context).size.width,
              child: RaisedButton(
                color: Colors.blue,
                onPressed: getPredictions,
                child: Text("Get Prediction",style: TextStyle(color: Colors.white,fontSize: 18.0),),
              ),
            )
          ],
        ),
      ),
    );
  }
}
