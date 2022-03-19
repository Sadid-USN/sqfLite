import 'package:flutter/material.dart';

import 'package:progress_indicators/progress_indicators.dart';

import '../sql_db.dart';

class CompletedTodo extends StatefulWidget {
  const CompletedTodo({
    Key? key,
  }) : super(key: key);

  @override
  State<CompletedTodo> createState() => _CompletedTodoState();
}

class _CompletedTodoState extends State<CompletedTodo> {
  int count = 0;

  SQLdb sqlDB = SQLdb();
  bool isLoading = true;
  List todos = [];
  int index = 0;
  Future read() async {
    List<Map> response =
        await sqlDB.readData('''SELECT * FROM todos WHERE done = 1''');

    todos = response.toList();
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    read();
    // todos.forEach((element) {
    //   if (element['done'] == 1) {
    //     count++;
    //   }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return todos.isEmpty
        ? Center(
            child: JumpingText(
              'Нет завершенных задач',
              style: const TextStyle(fontSize: 16),
            ),
          )
        : ListView.builder(
            itemCount: todos.length,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // Navigator.push(context, MaterialPageRoute(builder: (context) {
                  //   return EditPage(
                  //     title: todos[index]['title'],
                  //     todo: todos[index]['todo'],
                  //     id: todos[index]['id'],
                  //   );
                  // }));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    //height: 200,
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
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          activeColor: Theme.of(context).primaryColor,
                          checkColor: Colors.white,
                          value: true,
                          onChanged: (_) async {
                            int response = await sqlDB.updateData('''
                       UPDATE todos SET
                       done = 0
                       WHERE id = "${todos[index]['id']}"
                        ''');
                            setState(() {
                              read();
                            });
                            if (response > 0) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: const Duration(milliseconds: 1000),
                                  backgroundColor: Colors.orange[600],
                                  content: const Text('Вы вернули задачу 🔙'),
                                ),
                              );
                            }
                          },
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                todos[index]['title'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blueGrey.shade700,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                todos[index]['todo'],
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                                style: TextStyle(
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
              );
            },
          );
  }
}
