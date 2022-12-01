import 'package:flutter/material.dart';
import 'package:todo_app/Models/todo_model.dart';
import 'package:todo_app/Views/home_page_view/home_page_controller.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    final randomColor = getRandomColorForIcon()[0];
    final controller = HomePageController();
    ValueNotifier<TodoModel?> selecionado = ValueNotifier(null);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Row(
          children: [
            Icon(Icons.calendar_today_sharp, color: randomColor),
            const SizedBox(width: 8),
            const Text(
              "Today",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 22),
            ),
          ],
        ),
        actions: [
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
      body: FutureBuilder<List<TodoModel>>(
          future: controller.loadTodosList(),
          builder: (_, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(color: randomColor),
                    const SizedBox(height: 6),
                    const Text("Carregando sua lista de tarefas...")
                  ],
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data?.isNotEmpty == true) {
              return Center(
                child: ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (__, index) => ValueListenableBuilder<TodoModel?>(
                    valueListenable: selecionado,
                    builder: (_, TodoModel? todo, __) {
                      return RadioListTile<TodoModel?>(
                          toggleable: true,
                          value: snapshot.data?[index],
                          groupValue: selecionado.value,
                          title: Text('${snapshot.data?[index].title}'),
                          onChanged: (value) => selecionado.value = value);
                    },
                  ),
                ),
              );
            }
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Você não tem tarefas criadas. Vamos criar uma?'),
                  ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(randomColor)),
                      onPressed: () {},
                      label: const Text("Criar nova tarefa"),
                      icon: const Icon(Icons.add)),
                ],
              ),
            );
          }),
    );
  }

  List<Color> getRandomColorForIcon() {
    List<Color> colors = [
      Colors.blue,
      Colors.brown,
      Colors.cyan,
      Colors.deepOrange,
      Colors.deepPurple,
      Colors.purple,
      Colors.green,
      Colors.indigo,
      Colors.red,
      Colors.teal,
      Colors.pink,
    ];
    colors.shuffle();
    return colors;
  }
}
