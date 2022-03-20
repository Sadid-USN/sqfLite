import 'package:flutter/material.dart';
import 'package:flutter_locales/flutter_locales.dart';
import 'package:sql_db/home_page.dart';
import 'package:sql_db/screen/all_todo_page.dart';
import 'package:sql_db/sql_db.dart';

import '../main.dart';

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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const LocaleText('newtask'),
          centerTitle: true,
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
                        // validator: ((value) {
                        //   if (value!.isEmpty) {
                        //     return 'Обязательное поле';
                        //   }
                        //   return null;
                        // }),
                        controller: _titleController,
                        decoration: InputDecoration(
                          hintText: Locales.string(context, 'hinttitle'),
                        ),
                      ),
                      TextFormField(
                        maxLines: 5,
                        controller: _todoController,
                        decoration: InputDecoration(
                          hintText: Locales.string(context, 'hintdescription'),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      MaterialButton(
                        color: Colors.green,
                        onPressed: () async {
                          int response = await sqlDB.insertData('''
                           INSERT INTO todos (`title`, `todo`, `done`)
                           VALUES
                           ("${_titleController.text}",
                            "${_todoController.text}",
                            "0"


                            )
                            ''');
                          if (response > 0) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) {
                                  return const HomePage();
                                },
                              ),
                            );
                          } else {
                            return;
                          }

                          print("====== RESPONSE =======");
                        },
                        child: const LocaleText(
                          'savebutton',
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
      ),
    );
  }
}
