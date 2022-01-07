import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front/auth_pages/signup.dart';
import 'package:front/config/palette.dart';
import 'package:http/http.dart' as http;

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formkey = GlobalKey<FormState>(); //
  bool loading = false;

  String email = '';
  String password = '';
  String erreur = '';

  Future<http.Response> createUser(String email, String password) {
    return http.post(
      Uri.parse('http://20.87.48.193:3000/api/users/login'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'email': this.email, 'password': this.password}),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Email",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      //validator: (val) {
                      // if(val.length==0) {
                      //    return "Email cannot be empty";
                      //  }else{
                      //     return null;
                      //    }
                      ///  },
                      keyboardType: TextInputType.emailAddress,

                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Password ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      onChanged: (val) {
                        setState(() {
                          password = val;
                        });
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    GestureDetector(
                      onTap: () async {
                        //  FirebaseAuth.instance
                        //  .signInWithEmailAndPassword(email: email, password: password)
                        //  .then((user){
                        //    Navigator.of(context).pushReplacementNamed('/accueil');
                        //  }).catchError((e){print(e);});

                        //ajouter lauth apartir de la base de données
                        //  if (result==null){
                      },
                      child: Container(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/signuppage');
                          },
                          child: Text(
                            'Create New Account',
                          ),
                        ),
                        decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                                    width: 1, color: Colors.black38))),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                        createUser(email, password);
                        Navigator.of(context).pushReplacementNamed('/accueil');
                      },
                      color: Palette.orange,
                      child: Text(
                        "Sign In",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                    Text(
                      erreur,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ))),
    );
  }
}
