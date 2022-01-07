import 'package:flutter/material.dart';
import 'package:front/auth_pages/signin.dart';
import 'package:front/pages/accueil.dart';
import 'package:front/pages/profile.dart';
import 'package:front/pages/splashscreen.dart';
import 'package:front/pages/test_flame.dart';
import 'package:front/pages/test_humidity.dart';
import 'package:front/pages/test_temperature.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:front/auth_pages/signup.dart';

main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Forest app',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        textTheme:
            GoogleFonts.josefinSansTextTheme(Theme.of(context).textTheme),
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        canvasColor: Colors.transparent,
      ),
      home: SplashScreen(),
      routes: <String, WidgetBuilder>{
        '/signuppage': (BuildContext context) => const SignUp(),
         '/loginpage':(BuildContext context)=>SignInScreen(),
        '/accueil': (BuildContext context) => const WelcomePage(),
        // '/profile':(BuildContext context)=>ProfileView(),
        /////////////////////////////////////////////////
        //hathom li zidnahom
        //'loginjdid': (context) => LoginScreen(),
        // 'ForgotPassword': (context) => ForgotPassword(),
        //'CreateNewAccount': (context) => CreateNewAccount(),
      },
    );
  }
}
