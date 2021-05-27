import 'dart:math';

import 'package:flutter/material.dart';

import 'snake/config/config.dart';
import 'snake/index.dart';
import 'util/util.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Snake',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Snake Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final size = min(screenSize.width, screenSize.height);
    Config.size = size;
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: onPressed,
          child: Text('Snake'),
        ),
      ),
      // body: Table(
      //   columnWidths: const <int, TableColumnWidth>{
      //     0: FlexColumnWidth(),
      //     1: FlexColumnWidth(),
      //   },
      //   children: [],
      // ),
    );
  }

  void onPressed() {
    goto(context, SnakeScreen());
  }
}
