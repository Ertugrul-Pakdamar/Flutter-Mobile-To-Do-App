import 'package:flutter/material.dart';
import 'package:to_do/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async{
  // init the hive
  await Hive.initFlutter();

  // open a box
  var box = await Hive.openBox('myBox');

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: new ThemeData(primaryColor: Colors.yellow),
    );
  }
}
