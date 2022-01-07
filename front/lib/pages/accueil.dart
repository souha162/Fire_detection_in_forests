import 'package:flutter/material.dart';
import 'package:front/pages/profile.dart';
import 'package:front/pages/test_flame.dart';
import 'package:front/pages/test_humidity.dart';
import 'package:front/pages/test_temperature.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  static List<Widget> _widgetOptions = <Widget>[
    MyHomePge(),
    HumidityPage(),
   FlamePage(),
    
   
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  int _selectedIndex = 0;
  int alt = 10;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.filter_drama_rounded),
              label: 'Temperature',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.water),
              label: 'Humidity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit),
              label: 'Flame',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.amber[800],
          onTap: _onItemTapped),
    );
  }
}
