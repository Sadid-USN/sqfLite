import 'package:flutter/material.dart';
import 'package:sql_db/home_page.dart';
import 'package:sql_db/sql_db.dart';

class NextPage extends StatefulWidget {
  const NextPage({Key? key}) : super(key: key);

  @override
  State<NextPage> createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  SQLdb sqlDB = SQLdb();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _todoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEXT PAGE'),
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
                      controller: _titleController,
                      decoration: const InputDecoration(hintText: 'title'),
                    ),
                    TextFormField(
                      controller: _todoController,
                      decoration: const InputDecoration(hintText: 'todo'),
                    ),
                    MaterialButton(
                      color: Colors.greenAccent,
                      onPressed: () async {
                        int response = await sqlDB.insertData('''
                         INSERT INTO todos (`title`, `todo`)
                         VALUES ("${_titleController.text}", "${_todoController.text}")
                          ''');
                        if (response > 0) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const HomePage();
                          }));
                        }

                        print("====== RESPONSE =======");
                      },
                      child: const Text('Add todo'),
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
