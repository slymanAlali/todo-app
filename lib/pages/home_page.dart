import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:toddo/data/database.dart';
import 'package:toddo/util/todo_tile.dart';

import '../util/dialog_box.dart';

class HomePage extends StatefulWidget{
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  // referenc the hive box
  final _myBox = Hive.openBox('mybox');

  // text controller
  final _controller = TextEditingController();
  ToDoDataBase db = ToDoDataBase();

  @override
  void initState() {
    if(_myBox.get('TODOLIST') == null){
    db.createInitialData();
    super.initState();
  }

  // checkbox was tapped
  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.toDoList[index][1] = ! db.toDoList[index][1];
    });
  }

  // save new task
  void saveNewTask() {
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
  });
    Navigator.of(context).pop();
        }
  // create a new task
  void createNewTask() {
   showDialog(
       context: context,
       builder: (context){
         return DialogBox(
           controller: _controller,
           onSave: saveNewTask,
           onCancel: () => Navigator.of(context).pop(),
         );
       },
   );
  }
  // delete task
  void deleteTask(int index) {
    setState(() {
      db.toDoList.removeAt(index);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      appBar: AppBar(
     title:Text('To Do'),

        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child:Icon(Icons.add,
        color:Colors.purple),
      ),
      body:ListView.builder(
        itemCount:  db.toDoList.length,
        itemBuilder: (context, index){
          return ToDoTile(
              taskName:  db.toDoList[index][0],
              taskCompleted:  db.toDoList[index][1],
              onChanged: (value) => checkBoxChanged(value,index),
            deleteFunction: (context) => deleteTask,
          );
        },
      )
    );
  }
}






