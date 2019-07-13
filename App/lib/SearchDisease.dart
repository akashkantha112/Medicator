import 'dart:convert';
import 'dart:io';
import 'package:ciem_hackathon/Details.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class SearchDisease extends StatefulWidget {
  @override
  _SearchDiseaseState createState() => _SearchDiseaseState();
}

class _SearchDiseaseState extends State<SearchDisease> {
  TextEditingController _textEditingController;
  List<dynamic> names;
  Widget resultWidget;

  @override
  void initState() {
    super.initState();

    names = List();
    names.add("Dengue");
    names.add("Dengue1");
    names.add("Dengue2");
    names.add("Dengue3");
    _textEditingController = new TextEditingController();

    getResultWidget("");
  }

  Future<void> searchDiseases(String q) async {
    if (q.length == 0) {
      names = List();
    } else {
      var data = (q.toLowerCase().replaceAll(RegExp(r'\s+'), ' '));

      Map<String, String> mp = new Map();

      mp["query"] = data;

      print(mp);
      print(q);
      print(jsonEncode(mp));


      HttpClient  httpClient = new HttpClient();
      HttpClientRequest request = await httpClient.postUrl(Uri.parse("http://192.168.31.66:3000/search"));
      request.headers.set('content-type', 'application/json');
      request.add(utf8.encode(json.encode(mp)));
      HttpClientResponse response = await request.close();
      String reply = await response.transform(utf8.decoder).join();
      httpClient.close();


      var result = jsonDecode(reply);

      setState(() {

        print(result["res"]);
        names = result["res"];
      });

    }
  }

  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

  Future getResultWidget(s) {
    setState(() {
      resultWidget = FutureBuilder(
          future: searchDiseases(s),
          builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              return CircularProgressIndicator();
            } else if (snapshot.connectionState == ConnectionState.done) {
              return _textEditingController.text.length ==0 ? Center(child:Text("Search diseaes")):ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, index) {
                    return ListTile(
                      onTap: (){Navigator.push(context, PageTransition(child: Details(names[index]), type: PageTransitionType.downToUp));},
                      title: Text(capitalize(names[index])),
                      trailing: Icon(Icons.keyboard_arrow_right,color: Colors.white,),
                    );
                  });
            } else if (snapshot.connectionState == ConnectionState.none) {
              return Center(
                child: Text("Search for diseases"),
              );
            } else{
              return Center(child: CircularProgressIndicator());
            }
          });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  onChanged: getResultWidget,
                  decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: "Enter the disease name"),
                  controller: _textEditingController,
                ),
              ),
              Flexible(
                  child: Container(
                child: resultWidget,
              )),
            ],
          ),
        ),
      ),
    );
  }
}
