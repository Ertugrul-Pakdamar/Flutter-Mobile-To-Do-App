import 'package:hive_flutter/hive_flutter.dart';

class ToDoDatabase {
  List toDoList = [];

  //reference the box
  final _myBox = Hive.box('myBox');

  createInitialData() {
    toDoList = [];
  }

  loadData() async{
    toDoList = await _myBox.get("toDoList");
  }

  updateDatabase() async{
    await _myBox.put("toDoList", toDoList);
  }

}