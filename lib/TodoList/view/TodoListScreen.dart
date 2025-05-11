import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webreinventassignment/TodoList/widgets/CustomTextEditingWidget.dart';
import 'package:webreinventassignment/TodoList/viewmodel/TodoListViewModel.dart';
import 'package:webreinventassignment/Utils/constants/AppColor.dart';
import 'package:webreinventassignment/Utils/storage/TodoListStorage.dart';

final TodoListViewModel todoListCtrl = Get.put(TodoListViewModel());

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  @override
  void initState() {
    super.initState();
    todoListCtrl.todoList.value = TodoListStorage.getTodoList() ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColor.appMainColor,
          title: Text("ToDo List",
              style: GoogleFonts.montserrat(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600)),
          centerTitle: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: CustomTextEditingWidget(
              controller: todoListCtrl.todoTitleCrl,
              onAdd: (text) {
                todoListCtrl.addTodo(context);
              },
            ),
          ),
          Expanded(
            child: Obx(
              () => todoListCtrl.todoList.isEmpty
                  ? Center(
                      child: Text(
                      "No task added",
                      style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.w700, fontSize: 24),
                    ))
                  : ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading:todoListCtrl.todoList[index]['status'] == false? Checkbox(
                            onChanged: (value) =>
                                todoListCtrl.toggleTodoStatus(index),
                            value: todoListCtrl.todoList[index]['status'],
                          ):const SizedBox.shrink(),
                          title: Text(todoListCtrl.todoList[index]['title']),
                          subtitle: Text(todoListCtrl.todoList[index]['date']),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              todoListCtrl.todoList[index]['status'] == true
                                  ? Text("completed",style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w700, fontSize: 14),)
                                  : const SizedBox.shrink(),
                              IconButton(
                                icon:
                                    const Icon(Icons.delete, color: Colors.red),
                                onPressed: () => todoListCtrl.deleteTodo(index),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: todoListCtrl.todoList.length,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
