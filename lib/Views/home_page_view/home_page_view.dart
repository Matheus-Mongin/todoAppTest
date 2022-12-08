import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/Views/home_page_view/home_page_controller.dart';

import 'widgets/todo_card_list_widget.dart';

class HomePageView extends StatelessWidget {
  const HomePageView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = HomePageController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: const [
            Icon(Icons.calendar_today_sharp),
            SizedBox(width: 8),
            Text(
              "Today",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
        actions: [
          addTodoButton(controller: controller),
          PopupMenuButton(
            position: PopupMenuPosition.under,
            elevation: 1.5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(24),
              ),
            ),
            icon: const Icon(
              Icons.more_horiz_sharp,
              color: Colors.black,
            ),
            itemBuilder: (context) {
              return [
                const PopupMenuItem(
                  child: Text("Completed"),
                ),
                const PopupMenuItem(
                  child: Text("In Progress"),
                ),
                const PopupMenuItem(
                  child: Text("Removed"),
                ),
              ];
            },
          )
        ],
      ),
      body: FutureBuilder<List<TodoModel>?>(
          future: controller.loadTodosList(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircularProgressIndicator(),
                    SizedBox(height: 6),
                    Text("Carregando sua lista de tarefas...")
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data?.isNotEmpty == true) {
              return ValueListenableBuilder(
                valueListenable: controller.todos,
                builder: (_, __, ___) => TodoCardListWidget(
                  controller: controller,
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Você não tem tarefas criadas. Vamos criar uma?'),
                  addTodoButton(controller: controller),
                ],
              ),
            );
          }),
    );
  }
  
  IconButton addTodoButton({required HomePageController controller}) {
    return IconButton(
      onPressed: () => controller.addNewTodo(),
      icon: const Icon(Icons.add),
    );
  }
}
