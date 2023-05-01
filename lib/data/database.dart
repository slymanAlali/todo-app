import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase{
  List toDoList = [];

  // reference our box
final _myBox = Hive.box('mybox');

void createInitialData(){
  toDoList = [
    ['make tutorial',false],
    ['make tutorial',false],
  ];
}

void loadData() {
  toDoList = _myBox.get('TODOLIST');

}

void updataDataBase() {
  _myBox.put('TODOLIST', toDoList);

}

}