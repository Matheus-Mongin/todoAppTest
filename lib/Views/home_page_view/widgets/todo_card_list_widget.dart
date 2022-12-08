import 'package:flutter/material.dart';
import 'package:todo_app/Views/home_page_view/home_page_controller.dart';

import '../../../Models/todo_model.dart';

class TodoCardListWidget extends StatelessWidget {
  final HomePageController controller;

  const TodoCardListWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Center(
        child: ValueListenableBuilder<List<TodoModel>?>(
          valueListenable: controller.selecionados,
          builder: (_, List<TodoModel>? todo, __) => ListView.builder(
            itemCount: controller.todos.value?.length,
            itemBuilder: (context, index) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              color: Colors.grey[100],
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
              child: CheckboxListTile(
                controlAffinity: ListTileControlAffinity.leading,
                title: Text(
                  '${controller.selecionados.value?[index].title}',
                  style: TextStyle(
                      decoration:
                          controller.selecionados.value?[index].isChecked == true
                              ? TextDecoration.lineThrough
                              : TextDecoration.none),
                ),
                value: controller.selecionados.value?[index].isChecked,
                onChanged: (val) => controller.updateTodo(
                    todo: controller.selecionados.value?[index], isChecked: val),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
