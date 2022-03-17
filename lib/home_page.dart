import 'package:flutter/material.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:sql_db/screen/all_todo_page.dart';
import 'package:sql_db/screen/completed_todo.dart';
import 'package:sql_db/sql_db.dart';

import 'screen/add_todo_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SQLdb sqlDB = SQLdb();
  bool isLoading = true;
  List todos = [];

  Future read() async {
    List<Map> response = await sqlDB.readData("SELECT * FROM todos");
    todos.addAll(response);
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  bool isEmpty = false;
  int selectedIndex = 0;
  final _tabs = [
    const AllTodoPage(),
    const CompletedTodo(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // actions: [
        //   IconButton(
        //       onPressed: () async {
        //         await sqlDB.deleteAllDataBase();

        //         Navigator.of(context)
        //             .pushReplacement(MaterialPageRoute(builder: (context) {
        //           return const HomePage();
        //         }));
        //       },
        //       icon: const Icon(Icons.delete))
        // ],
        title: const Text(
          'ЗАДАЧИ',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) {
                return const AddTodo();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white.withOpacity(0.7),
        selectedItemColor: Colors.white,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() {
          selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.task_outlined,
              size: 30,
            ),
            label: 'Задача',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.check_circle_outline,
              size: 30,
            ),
            label: 'Завершенные',
          ),
        ],
      ),
      body: isEmpty
          ? Center(
              child: JumpingText(
              'Sabr...',
              style: const TextStyle(fontSize: 16),
            ))
          : _tabs[selectedIndex],
    );
  }
}
