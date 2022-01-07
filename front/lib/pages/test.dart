import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

math.Random random = new math.Random();

List<double> _generateRandomData(int count) {
  List<double> result = <double>[];
  for (int i = 0; i < count; i++) {
    result.add(random.nextDouble() * 100);
  }
  return result;
}

class MyHomePge extends StatefulWidget {
  @override
  State<MyHomePge> createState() => _MyHomePgeState();
}

class _MyHomePgeState extends State<MyHomePge> {
  String date = "";

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate1 = DateTime.now();
  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
  }

  _selectDate1(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate1,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate1 = selected;
      });
    }
  }

  Future<List> fetchPost() async {
    final response = await http.get(
        'http://localhost:3000/api/sensors/temperature?startDate=2022-01-01&endDate=2022-01-31');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      late List<dynamic> values;
      late List<double> L = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            L.add(double.parse(values[i]["temperatureValue"]));
          }
        }
      }
      return L;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    var data = _generateRandomData(100);
    return MaterialApp(
      home: new Scaffold(
        appBar: AppBar(
          title: Text("view dashbord"),
          backgroundColor: Color.fromARGB(255, 12, 142, 218),
          elevation: 0.0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    color: Colors.lightBlueAccent,
                    width: 100,
                    height: 20,
                    child: Center(child: Text("choose date "))),
              ),
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              GestureDetector(
                onTap: () {
                  _selectDate1(context);
                },
                child: Container(
                    color: Colors.lightBlueAccent,
                    width: 100,
                    height: 20,
                    child: Center(child: Text("choose date "))),
              ),
              Text(
                  "${selectedDate1.day}/${selectedDate1.month}/${selectedDate1.year}"),
              SizedBox(
                height: 20.0,
              ),
              FutureBuilder<List>(
                  future: fetchPost(),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      print("jajazjenhkjezn");
                      print(snapshot.data);
                    }
                    return Text('hahahahahahahahahah');
                  }),
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("Temperture graphe"),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        width: 350.0,
                        height: 200.0,
                        child: new Sparkline(
                          data: data,
                          lineColor: Color.fromARGB(255, 74, 198, 219),
                          fillMode: FillMode.below,
                          fillColor: Color.fromARGB(255, 48, 48, 199),
                          pointsMode: PointsMode.all,
                          pointSize: 5.0,
                          pointColor: Color.fromARGB(255, 138, 175, 243),
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

  @override
  void initState() {
    fetchPost();
  }
}
