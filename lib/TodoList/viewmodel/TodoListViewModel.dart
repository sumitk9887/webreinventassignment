import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:webreinventassignment/TodoList/view/TodoListScreen.dart';
import 'package:webreinventassignment/Utils/storage/TodoListStorage.dart';

class TodoListViewModel extends GetxController {
  RxList<Map<String, dynamic>> todoList = <Map<String, dynamic>>[].obs;
  final TextEditingController todoTitleCrl = TextEditingController();

  void saveTodoList() {
    TodoListStorage.setTodoList(todoList);
  }

  void addTodo(BuildContext context) {
    final newTodo = {
      'title': todoTitleCrl.value.text,
      'status': false,
      'date': DateFormat('hh:mm a').format(DateTime.now()) // HH:MM AM/PM format
    };
    todoList.add(newTodo);
    todoList.refresh();
    saveTodoList();
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      duration: Duration(milliseconds: 500),
      content: Text(
        "Task added successfully!",
        style: TextStyle(color: Colors.white),
      ),
    ));
  }

  void toggleTodoStatus(int index) {
    todoList[index]['status'] = !todoList[index]['status'];
    todoList.refresh();
    saveTodoList();
  }

  void deleteTodo(int index) {
    todoList.removeAt(index);
    todoList.refresh();
    saveTodoList();
  }

  void onSubmit(BuildContext context) {
    FocusScope.of(context).unfocus();
    if (todoTitleCrl.text.isNotEmpty) {
      addTodo(context);
      todoTitleCrl.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration: Duration(milliseconds: 800),
        content: Text(
          "Please enter some task to be added",
          style: TextStyle(color: Colors.white),
        ),
      ));
    }
  }
}
