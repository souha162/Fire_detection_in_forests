import 'package:flutter/material.dart';
import 'package:front/auth_pages/signin.dart';
import 'package:http/http.dart' as http;
import '../config/palette.dart';
import 'dart:convert';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>(); //
  bool loading = false;
  String email = '';
  String picUrl = '';
  String username = '';
  String service = '';
  String phonenumber = '';
  String password = '';
  String  password_confirmed= '';
  String erreur = '';

  bool isPasswordCompliant(String password, [int minLength = 6]) {
  if (password == null || password.isEmpty) {
    return false;
  }

  bool hasUppercase = password.contains(new RegExp(r'[A-Z]'));
  bool hasDigits = password.contains(new RegExp(r'[0-9]'));
  bool hasLowercase = password.contains(new RegExp(r'[a-z]'));
  bool hasSpecialCharacters = password.contains(new RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool hasMinLength = password.length > minLength;

  return hasDigits & hasUppercase & hasLowercase & hasSpecialCharacters & hasMinLength;
}

  Future<http.Response> createUser(String email, String password,
      String username, String picUrl, String phonenum, String service) {
    return http.post(Uri.parse('https://www.projetcot.me/api/users//register'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': email,
          'userName': username,
          'password': password,
          'service': service,
          'phoneNumber': phonenum,
          'picUrl': picUrl,
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("SignUp Page"),
        backgroundColor: Colors.blue,
        elevation: 0.0,
      ),
      body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
          child: Form(
              key: _formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Username",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      //validator: (val) {
                      //  if(val.length==0) {
                      //    return "Email cannot be empty";
                      //  }else{
                      //    return null;
                      //   }
                      // },
                      keyboardType: TextInputType.emailAddress,

                      onChanged: (val) {
                        setState(() {
                          username = val;
                        });
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Phone number ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() {
                          phonenumber = val;
                        });
                      },
                            validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter phone number';
                    }
                    return null;
                  },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter your service ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() {
                          service = val;
                        });
                      },
                   validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your service';
                    }
                    return null;
                  },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter pic Url ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() {
                          picUrl = val;
                        });
                      },
                          validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a valid URL';
                  }
                  return null;
                },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Enter Email ",
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (val) {
                        setState(() {
                          email = val;
                        });
                      },
                    validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a valid email';
                    }
                    return null;
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
                     validator: (value) {
                    if (value == null || value.isEmpty||value.length<6||isPasswordCompliant(value)==false) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: "Confirm Password ",
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
                          password_confirmed = val;
                        });
                      },
                      validator: (value) {
                    if (value == null || value.isEmpty||value.length<6||isPasswordCompliant(value)==false||password!=password_confirmed) {
                      return 'Please enter a valid password';
                    }
                    return null;
                  },
                    ),
                    SizedBox(
                      height: 40.0,
                    ),
                    RaisedButton(
                      onPressed: () {
                         if (_formkey.currentState!.validate()) {

                           createUser(email, password, username, picUrl,
                            phonenumber, service);
                        Navigator.of(context).pushReplacementNamed('/accueil');
                        // you'd often call a server or save the information in a database.
                      
                    }else{
                         ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Something wrong')),
                      );
                        
                    }
                   
                      },
                      color: Palette.orange,
                      child: Text(
                        "Sign Up",
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
