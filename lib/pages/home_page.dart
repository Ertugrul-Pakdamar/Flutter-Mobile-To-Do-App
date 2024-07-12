import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:to_do/data/database.dart';
import 'package:to_do/utilities/dialog_box.dart';
import 'package:to_do/utilities/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // reference hive box
  final _myBox = Hive.box('myBox');
  ToDoDatabase db = ToDoDatabase();

  @override
  void initState() {
    super.initState();
    if(_myBox.get("toDoList")==null) {
      db.createInitialData();
      setState(() {
        db.toDoList = [];
      });
    }
    else {
      db.loadData();
      setState(() {
        db.toDoList = _myBox.get("toDoList");
      });
    }
  }

  final _controller = TextEditingController();


  checkBoxChanged(int index) {
    setState(() {
      db.toDoList[index][1] = !db.toDoList[index][1];
    });
    db.updateDatabase();
  }

  saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text, false]);
    });
    _controller.text = '';
    db.updateDatabase();
    Navigator.of(context).pop();
  }

  createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.text = '';
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
      db.updateDatabase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text('TO DO'),
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
          return ToDoTile(
            taskName: db.toDoList[index][0],
            isTaskCompleted: db.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
