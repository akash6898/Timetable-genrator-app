import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'example.dart';
import 'professer.dart';
import 'package:get/get.dart';
import 'course.dart';
import 'time.dart';
import 'mainpage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<graphco>(
      create: (context) => graphco(),
      child: mainpage(),
    );
  }
}
