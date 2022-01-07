import 'dart:math' as math;
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
 import 'dart:math';
math.Random random = new math.Random();

List<double> _generateRandomData(int count) {
  List<double> result = <double>[];
  for (int i = 0; i < count; i++) {
    result.add(random.nextDouble() * 100);
  }
  return result;
}

class FlamePage extends StatefulWidget {
  @override
  State<FlamePage> createState() => _FlamePageState();
}

class _FlamePageState extends State<FlamePage> {


  List<double> query=[];
  List<int> queryint=[];
  int max1=0;
  int min1=0;

  String debutdate="2022-01-01";
  String findate="2022-01-06";

int findMin(List<int> numbers) {
  return numbers.reduce(min);
}

int findMax(List<int> numbers) {
  return numbers.reduce(max);
}

   void initState() {
    super.initState();
    fetchPost(debut:debutdate,fin:findate).then((value) {
      setState(() {
        query = value;
        queryint = query.map((i) => i.toInt()).toList();
        max1=findMax(queryint);
        min1=findMin(queryint);
        print(query);
      }
      
      );
    });
  }

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

  Future<List<double>> fetchPost({required String debut, required String fin}) async {
    final response = await http.get(
        'http://20.87.48.193:3000/api/sensors/flame?startDate=$debut&endDate=$fin');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      late List<dynamic> values;
      late List<double> L = [];
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            if(values[i]["flameValue"]==true){L.add(1.0);}
            else{L.add(0.0);}
              
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
          title: Text("Flame Dashboard"),
          backgroundColor: Color.fromARGB(255, 12, 142, 218),
          elevation: 0.0,
          actions: [
    IconButton(
      onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text("LogOut"),
                  
                  actions: <Widget>[
                    Row(
                      children: [
                      FlatButton(
                                onPressed: () {
                                 Navigator.of(ctx).pop();
                                 Navigator.of(context).pushReplacementNamed('/loginpage');
                                },
                                child: Text("okay"),
                              ),
                              SizedBox(width: 20.0,),
                               FlatButton(
                                onPressed: () {
                                  Navigator.of(ctx).pop();
                                },
                                child: Text("No"),
                              ),
                      ],
                    )
                    
                  ],
                ),
              );
            },
      icon: Icon(Icons.logout),
    ),
    
  ],
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
                     width: MediaQuery.of(context).size.width-10,
                    height: 35,
                    decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 24, 181),
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                    child: Center(child: Text("choose begin date "))),
              ),
              Text(
                  "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}"),
              GestureDetector(
                onTap: () {
                  _selectDate1(context);
                  
                },
                child: Container(
                     width: MediaQuery.of(context).size.width-10,
                    height: 35,
                    decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 24, 181),
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                    child: Center(child: Text("choose final date  "))),
              ),
              Text(
                  "${selectedDate1.day}/${selectedDate1.month}/${selectedDate1.year}"),
                  const SizedBox(
                height: 20.0,
              ),

              GestureDetector(
                onTap: () {
                 setState(() {
                debutdate= "${selectedDate.year}-${selectedDate.month}-${selectedDate.day}";
                 findate="${selectedDate1.year}-${selectedDate1.month}-${selectedDate1.day}";
                //  debutdate="2022-01-01";
                // findate="2022-01-30";
                fetchPost(debut:debutdate,fin:findate).then((value) {
                setState(() {
                  query = value;
                  print(query);
                  queryint = query.map((i) => i.toInt()).toList();
                  max1=findMax(queryint);
                  min1=findMin(queryint);
                  print(findate);
                }
      
      );
    });
                    print("saif");
                  });
                  
                },
                child: Container(
                     width: MediaQuery.of(context).size.width-10,
                    height: 35,
                    decoration: BoxDecoration(
                            color: Color.fromARGB(255, 40, 24, 181),
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                    child: Center(child: Text("searh"))),
              ),
              const SizedBox(
                height: 20.0,
              ),
              
      
              
              query!=null?FutureBuilder<List>(
                  future: fetchPost(debut: debutdate,fin: findate),
                  builder:
                      (BuildContext context, AsyncSnapshot<List> snapshot) {
                    if (snapshot.hasData) {
                      return  Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Text("flame graphe"),
                      SizedBox(
                        height: 25.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width-10,
                        height: MediaQuery.of(context).size.height/4,
                        child: Sparkline(
                          data: query,
                          
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
              );
         
                      
                    }
                    return Text('');
                  }):CircularProgressIndicator(),

                Card(
                  child: Container(
                    width:MediaQuery.of(context).size.width-10,
                    height: MediaQuery.of(context).size.height/6,
                    child: Row(children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 115, 239, 212),
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          child:Center(child: Column(children: [
                            Text('MAX'),
                            Text("${max1}")
                          ],
                          ) 
                          )
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width/3,
                          height: 50,
                          decoration: BoxDecoration(
                            color: Color.fromARGB(255, 115, 239, 212),
                          
                          borderRadius: BorderRadius.all(Radius.circular(20))
                            ),
                          child: Column(children: [
                            
                            Text('MIN'),
                            Text("${min1}")
                          ],
                          ) 
                          
                      ),
                 
                     ) ],),
                  
                  ),
                )
             
            ],
          ),
        ),
      ),
    );
  }

  
}
