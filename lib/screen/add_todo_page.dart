import 'package:flutter/material.dart';
import 'package:sql_db/home_page.dart';
import 'package:sql_db/sql_db.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  State<AddTodo> createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  SQLdb sqlDB = SQLdb();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  final TextEditingController _done = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ДОБАВИТЬ ЗАДАЧУ'),
      ),
      body: Container(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      validator: ((value) {
                        if (value!.isEmpty) {
                          return 'Обязательное поле';
                        }
                        return null;
                      }),
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: 'Заголовак'),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Добавьте описание';
                        }
                        return null;
                      },
                      maxLines: 3,
                      controller: _todoController,
                      decoration: const InputDecoration(hintText: 'Описание'),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // TextFormField(
                    //   validator: ((value) {
                    //     if (value!.isEmpty) {
                    //       return 'Обязательное поле';
                    //     }
                    //     return null;
                    //   }),
                    //   controller: _done,
                    //   decoration: const InputDecoration(hintText: 'Заголовак'),
                    // ),
                    MaterialButton(
                      color: Colors.green,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          int response = await sqlDB.insertData('''
                         INSERT INTO todos (`title`, `todo`, `done`)
                         VALUES
                         ("${_titleController.text}",
                          "${_todoController.text}",
                         "1"


                          )
                          ''');
                          if (response > 0) {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomePage();
                                },
                              ),
                            );
                          } else {
                            return;
                          }
                        }

                        print("====== RESPONSE =======");
                      },
                      child: const Text(
                        'Сохранить',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              )
              // FutureBuilder(
              //   future: readData(),
              //   builder:
              //       ((BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
              //     if (snapshot.hasData) {
              //       return ListView.builder(
              //           itemCount: snapshot.data!.length,
              //           physics: const NeverScrollableScrollPhysics(),
              //           shrinkWrap: true,
              //           itemBuilder: (context, index) {
              //             return Card(
              //               child: ListTile(
              //                 title: Text(snapshot.data![index]['todo']),
              //               ),
              //             );
              //           });
              //     }
              //     return const Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   }),
              // ),
            ],
          )),
    );
  }
}
