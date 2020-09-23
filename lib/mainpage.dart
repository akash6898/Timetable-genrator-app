import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example.dart';
import 'professer.dart';
import 'package:get/get.dart';
import 'course.dart';
import 'time.dart';

class mainpage extends StatefulWidget {
  @override
  _mainpageState createState() => _mainpageState();
}

class _mainpageState extends State<mainpage> {
  graphco g;
  int _currentIndex = 0;
  Widget Body() {
    if (_currentIndex == 0) {
      return Professer();
    } else if (_currentIndex == 1) {
      return Course();
    } else if (_currentIndex == 2) {
      return Time();
    }
  }

  @override
  Widget build(BuildContext context) {
    g = Provider.of<graphco>(context, listen: false);
    return MaterialApp(
      navigatorKey: Get.key,
      home: Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          title: Text("Time Table Generator"),
          actions: [
            IconButton(icon: Icon(Icons.calendar_today), onPressed: null)
          ],
        ),
        body: FutureBuilder<bool>(
            future: g.setStorage(),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.data == true) return Body();
            }),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex:
              _currentIndex, // this will be set when a new tab is tapped
          items: [
            BottomNavigationBarItem(
              icon: IconButton(
                  icon: Icon(Icons.person),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 0;
                    });
                  }),
              title: new Text('Professer'),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                  icon: Icon(Icons.subject),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  }),
              title: new Text('subject'),
            ),
            BottomNavigationBarItem(
              icon: IconButton(
                  icon: Icon(Icons.access_time),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 2;
                    });
                  }),
              title: new Text('Time'),
            ),
          ],
        ),
      ),
    );
  }
}
