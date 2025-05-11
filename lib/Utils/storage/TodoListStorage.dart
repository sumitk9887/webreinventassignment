import 'package:get_storage/get_storage.dart';

class TodoListStorage {
  static String todoList = "todoList";

  static GetStorage storage = GetStorage();

  static setTodoList(List<Map<String, dynamic>> data) async {
    await storage.write(todoList, data);
  }

  static List<Map<String, dynamic>> getTodoList() {
    List<dynamic>? storedList = storage.read(todoList);
    if (storedList != null) {
      return List<Map<String, dynamic>>.from(storedList);
    }
    return [];
  }
  static cleanAllLocalStorage() {
    storage.erase();
  }
}
