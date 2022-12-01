import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo_model.dart';

class HomePageController {
  late ValueNotifier<bool> hasTodo = ValueNotifier(false);

  Future<List<TodoModel>> loadTodosList() async {
    final todos = [
      TodoModel(title: 'Comprar pão amanhã', isChecked: false),
      TodoModel(title: 'Dentista às 17:00h', isChecked: false)
    ];

    return Future.delayed(const Duration(seconds: 2)).then((value) => todos);
  }
}
