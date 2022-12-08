import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo_model.dart';

class HomePageController extends ChangeNotifier {
  ValueNotifier<List<TodoModel>?> todos = ValueNotifier(null);
  ValueNotifier<List<TodoModel>?> selecionados = ValueNotifier([]);

  Future<List<TodoModel>?> loadTodosList() async {
    todos.value = [
      TodoModel(title: 'Comprar pão amanhã', isChecked: false),
      TodoModel(title: 'Dentista às 17:00h', isChecked: false)
    ];

    selecionados.value = todos.value;
    return Future.delayed(const Duration(seconds: 0))
        .then((value) => todos.value);
  }

  void addNewTodo() {
    todos.value?.add(TodoModel(title: "Lorem Ipsum", isChecked: false));
    selecionados.value = todos.value;
    selecionados.notifyListeners();
  }

  void updateTodo({bool? isChecked = false, required TodoModel? todo}) {
    if (todo != null) {
      final ind = todos.value?.indexOf(todo);
      if (ind != null && isChecked != null) {
        todos.value?[ind].isChecked = isChecked;
      }
    }
    selecionados.notifyListeners();
  }
}
