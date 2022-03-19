import 'package:flutter/material.dart';
import 'package:sql_db/home_page.dart';
import 'package:sql_db/sql_db.dart';

class EditPage extends StatefulWidget {
  final String title;
  final String todo;
  final int id;
  final int done;

  const EditPage(
      {Key? key, this.title = '', this.todo = '', this.id = 0, this.done = 0})
      : super(key: key);

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  SQLdb sqlDB = SQLdb();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();

  @override
  void initState() {
    _titleController.text = widget.title;
    _todoController.text = widget.todo;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Изменить задачу'),
          centerTitle: true,
        ),
        body: ListView(padding: const EdgeInsets.all(16.0), children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  maxLines: 1,
                  controller: _titleController,
                  decoration: const InputDecoration(hintText: 'Заголовак'),
                ),
                TextFormField(
                  maxLines: 10,
                  controller: _todoController,
                  decoration: const InputDecoration(hintText: 'Описание'),
                ),
                const SizedBox(
                  height: 10,
                ),
                MaterialButton(
                  color: Colors.green,
                  onPressed: () async {
                    int response = await sqlDB.updateData('''
                         UPDATE todos SET
                         title = "${_titleController.text}",
                         todo  = "${_todoController.text}"
                         WHERE id = "${widget.id}"

                          ''');
                    if (response > 0) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) {
                          return const HomePage();
                        }),
                      );
                    }

                    print("====== RESPONSE =======");
                  },
                  child: const Text(
                    'Изменить',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
