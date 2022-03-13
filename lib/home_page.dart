import 'package:flutter/material.dart';
import 'package:sql_db/sql_db.dart';

import 'next_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  SQLdb sqlDB = SQLdb();
  Future<List<Map>> readData() async {
    List<Map> response = await sqlDB.readData("SELECT * FROM todos");
    return response;
  }

  int? indexID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('SQL LITE'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return const NextPage();
            }));
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          child: Column(
            children: [
              FutureBuilder(
                future: readData(),
                builder:
                    ((BuildContext context, AsyncSnapshot<List<Map>> snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(snapshot.data![index]['title']),
                              subtitle: Text(snapshot.data![index]["todo"]),
                              leading:
                                  Text(snapshot.data![index]["id"].toString()),
                            ),
                          );
                        });
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }),
              ),
              Center(
                child: MaterialButton(
                  color: Colors.green.shade400,
                  onPressed: () async {
                    int response = await sqlDB.insertData('''
                         INSERT INTO todos (`title`, `todo`)
                         VALUES ("Садид", "Идибеков")
                          ''');

                    List<Map<String, dynamic>> responseRead =
                        await sqlDB.readData("SELECT * FROM 'todos' ");

                    if (responseRead.isNotEmpty) {
                      setState(() {});
                    }
                    print(response);
                  },
                  child: const Text('INSERT & READ DATA'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              // Center(
              //   child: MaterialButton(
              //     color: Colors.green.shade400,
              //     onPressed: () async {},
              //     child: const Text('READ DATA'),
              //   ),
              // ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.red.shade400,
                  onPressed: () async {
                    await sqlDB.deleteAllDataBase();
                    setState(() {});
                  },
                  child: const Text('DELETE ALL DATA'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.red.shade700,
                  onPressed: () async {
                    await sqlDB.deleteOneData('''
                   DELETE FROM 'todos' WHERE id = 1

                  ''');
                    setState(() {});
                  },
                  child: const Text('DELETE ONE DATA'),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Center(
                child: MaterialButton(
                  color: Colors.orange,
                  onPressed: () async {
                    int response = await sqlDB.updateData(
                        "UPDATE  'todos' SET 'todo' = 'изучаем SQF LITE'  WHERE id = 1");
                    print(response);
                  },
                  child: const Text('UPDATE DATA'),
                ),
              ),
            ],
          ),
        ));
  }
}
