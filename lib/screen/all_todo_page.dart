import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../sql_db.dart';

import 'edit_page.dart';

class AllTodoPage extends StatefulWidget {
  const AllTodoPage({Key? key}) : super(key: key);

  @override
  State<AllTodoPage> createState() => _AllTodoPageState();
}

class _AllTodoPageState extends State<AllTodoPage> {
  SQLdb sqlDB = SQLdb();
  bool isLoading = true;
  List todos = [];
  bool boolValue = false;

  Future read() async {
    List<Map> response =
        await sqlDB.readData("SELECT * FROM todos WHERE done = 0");
    todos = response.toList();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    read();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? Center(
            child: JumpingText(
              Locales.string(context, 'empty'),
              style: const TextStyle(fontSize: 16),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            itemCount: todos.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return EditPage(
                          title: todos[index]['title'],
                          todo: todos[index]['todo'],
                          id: todos[index]['id'],
                          done: todos[index]['done'],
                        );
                      },
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Slidable(
                    // key: Key(todo!.id),
                    startActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return EditPage(
                                title: todos[index]['title'],
                                todo: todos[index]['todo'],
                                id: todos[index]['id'],
                                done: todos[index]['done'],
                              );
                            }));
                          },
                          backgroundColor: Colors.green.withOpacity(0.6),
                          foregroundColor: Colors.white,
                          icon: Icons.edit,
                          label: Locales.string(context, 'editbutton'),
                        ),
                      ],
                    ),
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          onPressed: (context) async {
                            // Удаляет данные из базы SQL
                            int response = await sqlDB.deleteOneData('''
                              DELETE FROM todos WHERE id = "${todos[index]['id']}"
                              ''');

                            //Удаляет данные выполняя рефреш страницы
                            if (response > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  duration: Duration(milliseconds: 1100),
                                  backgroundColor: Colors.red,
                                  content: LocaleText('deletesnackbar'),
                                ),
                              );
                              todos.removeWhere((element) =>
                                  element['id'] == todos[index]['id']);
                              setState(() {});
                            }
                          },
                          backgroundColor: Colors.red.withOpacity(0.8),
                          foregroundColor: Colors.white,
                          icon: Icons.delete,
                          label: Locales.string(context, 'delete'),
                        ),
                      ],
                    ),
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      width: double.infinity,
                      padding: const EdgeInsets.all(20.0),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        color: Color(0xffF3EEE2),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0.0, 2.0),
                              blurRadius: 6.0)
                        ],
                      ),
                      child: Row(
                        children: [
                          Checkbox(
                            value: false,
                            onChanged: (_) async {
                              int response = await sqlDB.updateData('''
                       UPDATE todos SET
                       done = 1
                       WHERE id = "${todos[index]['id']}"
                        ''');
                              setState(() {
                                read();
                              });
                              if (response > 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    backgroundColor: Colors.green[600],
                                    content:
                                        const LocaleText('completednackbar'),
                                  ),
                                );
                              }
                            },
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  todos[index]['title'],
                                  maxLines: 1,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.blueGrey.shade700,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(
                                  height: 14,
                                ),
                                Text(
                                  todos[index]['todo'],
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    color: Colors.grey.shade900,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
  }
}
