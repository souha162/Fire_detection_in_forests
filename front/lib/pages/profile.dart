import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:front/model/user_model.dart';
import 'package:http/http.dart' as http;

class PostHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: PostScreen(),
      ),
    );
  }
}

class PostScreen extends StatefulWidget {
  @override
  _PostScreenState createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  Future<List> fetchPost() async {
    final response = await http.get('http://localhost:3000/users/');

    if (response.statusCode == 200) {
      // If the call to the server was successful, parse the JSON
      late List<dynamic> values;
      values = json.decode(response.body);
      if (values.length > 0) {
        for (int i = 0; i < values.length; i++) {
          if (values[i] != null) {
            print(values[i]);
          }
        }
      }
      return values;
    } else {
      // If that call was not successful, throw an error.
      throw Exception('Failed to load post');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("voila"),
        ),
        body: FutureBuilder<List>(
            future: fetchPost(),
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(snapshot.data![index]['userName']),
                        subtitle: Text(snapshot.data![index]['email']),
                      );
                    });
              }
              return Text('');
            }));
  }

  @override
  void initState() {
    fetchPost();
  }
}
