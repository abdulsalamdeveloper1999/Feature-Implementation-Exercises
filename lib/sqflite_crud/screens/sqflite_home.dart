import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tutorials_project/sqflite_crud/db_helper/db_helper.dart';
import 'package:tutorials_project/sqflite_crud/models/notes_model.dart';

import '../../componnets/custom_snackbar.dart';

class SqfliteFetch extends StatefulWidget {
  const SqfliteFetch({super.key});

  @override
  State<SqfliteFetch> createState() => _SqfliteFetchState();
}

class _SqfliteFetchState extends State<SqfliteFetch> {
  DBHelper? db;
  TextEditingController name = TextEditingController();
  TextEditingController age = TextEditingController();
  TextEditingController address = TextEditingController();

  @override
  void initState() {
    db = DBHelper();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Sqflite Crud'),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              showDialog(
                builder: (_) {
                  return AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: name,
                          decoration: const InputDecoration(hintText: 'Name'),
                        ),
                        TextField(
                          controller: age,
                          decoration: const InputDecoration(hintText: 'Age'),
                        ),
                        TextField(
                          controller: address,
                          decoration:
                              const InputDecoration(hintText: 'Address'),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          insertData().then((value) {
                            log('Data added');

                            setState(() {});
                          }).onError((error, stackTrace) {
                            log(error.toString());
                          });
                          showSnackBar(
                            context,
                            'Data has been Inserted',
                          );
                          name.clear();
                          age.clear();
                          address.clear();
                          Navigator.pop(context);
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
                context: context,
              );
            },
            child: const Icon(Icons.add),
          ),
          body: FutureBuilder(
            future: db!.fetchRecords(),
            builder: (context, AsyncSnapshot<List<NotesModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else if (snapshot.hasData) {
                if (snapshot.data!.isEmpty) {
                  return const Center(child: Text('No Data Available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      var note = snapshot.data![
                          index]; // Get the NoteModel from the snapshot data
                      return ListTile(
                        leading: IconButton(
                          onPressed: () {
                            name.text = note.name!;
                            age.text = note.age!.toString();
                            address.text = note.address!;
                            showDialog(
                              builder: (_) {
                                return AlertDialog(
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      TextField(
                                        controller: name,
                                        decoration: const InputDecoration(
                                          hintText: 'Name',
                                        ),
                                      ),
                                      TextField(
                                        controller: age,
                                        decoration: const InputDecoration(
                                          hintText: 'Age',
                                        ),
                                      ),
                                      TextField(
                                        controller: address,
                                        decoration: const InputDecoration(
                                          hintText: 'Address',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        name.clear();
                                        age.clear();
                                        address.clear();
                                      },
                                      child: const Text(
                                        'Cancel',
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        updateData(note);
                                        showSnackBar(
                                          context,
                                          'Data has been updated',
                                        );
                                        name.clear();
                                        age.clear();
                                        address.clear();
                                        setState(() {
                                          db!.fetchRecords();
                                        });
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Update'),
                                    ),
                                  ],
                                );
                              },
                              context: context,
                            );
                          },
                          icon: const Icon(Icons.edit),
                        ),
                        title: Text(
                          note.name!,
                        ),
                        subtitle: Text(
                          "${note.age!} ${note.address!}",
                        ), // Display the name from your model
                        trailing: IconButton(
                          onPressed: () {
                            deleteData(note);

                            showSnackBar(
                              context,
                              'Data has been deleted',
                            );
                            setState(() {});
                          },
                          icon: const Icon(Icons.delete),
                        ),
                      );
                    },
                  );
                }
              } else if (snapshot.hasError) {
                log(snapshot.error.toString());
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: Text('No Data'));
            },
          )),
    );
  }

  Future<int> updateData(NotesModel note) {
    return db!.updateRecords(
      NotesModel(
        id: note.id,
        name: name.text,
        age: int.parse(age.text),
        address: address.text,
      ),
    );
  }

  Future<NotesModel> insertData() {
    return db!.insertRecord(
      NotesModel(
        name: name.text,
        age: int.parse(age.text),
        address: address.text,
      ),
    );
  }

  Future<int> deleteData(NotesModel note) => db!.deleteRecords(note.id!);
}
