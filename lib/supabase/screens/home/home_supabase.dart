import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tutorials_project/supabase/models/profile_model.dart';
import 'package:tutorials_project/supabase/services/db_services.dart';

import '../../../componnets/custom_snackbar.dart';

class HomeSupabase extends StatefulWidget {
  const HomeSupabase({super.key});

  @override
  State<HomeSupabase> createState() => _HomeSupabaseState();
}

class _HomeSupabaseState extends State<HomeSupabase> {
  // List<Map<String, dynamic>> userData =
  //     []; // Initialize an empty list to hold the fetched data

  TextEditingController employeeName = TextEditingController();
  TextEditingController employeeEmail = TextEditingController();
  SupabaseServices supabaseService = SupabaseServices();

  @override
  void dispose() {
    super.dispose();
    employeeEmail.dispose();
    employeeName.dispose();
  }

  @override
  void initState() {
    super.initState();
    // fetchData();
  }

  // Future<void> fetchData() async {
  //   // Call your fetchUserData method here and assign the result to the userData list
  //   final fetchedData = await SupabaseServices().fetchUserData();
  //   setState(() {
  //     userData = fetchedData;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addData(context);
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<ProfileModel>>(
          future: supabaseService.fetchUserDataWithRetry(),
          builder: (context, AsyncSnapshot<List<ProfileModel>> snapshot) {
            var data = snapshot.data;
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return ListView.builder(
              itemCount: data!.length,
              itemBuilder: (context, index) {
                final user = data[index];
                return ListTile(
                  leading: IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: employeeName = user.employeeName
                                        as TextEditingController,
                                    decoration: InputDecoration(
                                      hintText: user.employeeName,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  context.pop();
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: const Text('Update'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                  title: Text(user.employeeName),
                  subtitle: Row(
                    children: [
                      Text(user.employeeEmail),
                      const SizedBox(width: 10),
                      Text(user.id.toString()),
                    ],
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      setState(() {
                        supabaseService.deleteData(context, user.id.toString());
                        // fetchData();
                      });
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }),
    );
  }

  Future<dynamic> addData(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: employeeName,
                  decoration: const InputDecoration(
                    hintText: 'Employee Name',
                  ),
                ),
                TextField(
                  controller: employeeEmail,
                  decoration: const InputDecoration(
                    hintText: 'Employee Email',
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop();
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                if (employeeEmail.text.isNotEmpty &&
                    employeeName.text.isNotEmpty) {
                  supabaseService.createUser(
                    email: employeeEmail.text,
                    name: employeeName.text,
                  );
                  // fetchData();
                  context.pop();
                } else {
                  showSnackBar(context, 'Fields are required');
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
