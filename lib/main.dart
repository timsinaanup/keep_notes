import 'package:flutter/material.dart';
import 'package:notes/screen/Mynotes.dart';
import 'package:notes/screen/hiveManager.dart';

void main() async {
  await HiveManager.initHive();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const Mynotes(),
    );
  }
}
