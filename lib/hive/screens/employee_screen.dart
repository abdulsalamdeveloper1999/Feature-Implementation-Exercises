import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import '../models/employee.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({Key? key}) : super(key: key);

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  final name = TextEditingController();
  final address = TextEditingController();

  var box = Hive.box<EmployeeModel>('EmployeeModelbox');

  @override
  void dispose() {
    super.dispose();
    name.dispose();
    address.dispose();
  }

  clearController() {
    name.clear();
    address.clear();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: appBar(),
        floatingActionButton: addButton(context),
        body: ValueListenableBuilder(
          valueListenable: box.listenable(),
          builder: (context, Box<EmployeeModel> box, _) {
            if (box.values.isEmpty) {
              return const Center(
                child: Text("No Employes"),
              );
            } else {
              return ListView.separated(
                itemCount: box.values.length,
                itemBuilder: (context, index) {
                  var result = box.getAt(index);

                  return employeeCard(
                    result,
                    box,
                    index,
                  );
                },
                separatorBuilder: (context, i) {
                  return const SizedBox(height: 12);
                },
              );
            }
          },
        ),
      ),
    );
  }

  Widget employeeCard(
    EmployeeModel? result,
    Box<EmployeeModel> box,
    int index,
  ) {
    TextEditingController nameEdit = TextEditingController(text: result!.name);
    TextEditingController addressEdit =
        TextEditingController(text: result.address);
    return Container(
      margin: const EdgeInsets.only(top: 15, right: 15, left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Colors.deepPurple[200]!,
            offset: const Offset(1, 1),
          ),
        ],
      ),
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            showDialog(
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          decoration: InputDecoration(hintText: result.name!),
                          controller: nameEdit,
                        ),
                        TextField(
                          decoration:
                              InputDecoration(hintText: result.address!),
                          controller: addressEdit,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          await box.putAt(
                            index,
                            EmployeeModel(
                              name: nameEdit.text,
                              address: addressEdit.text,
                            ),
                          );
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context);
                        },
                        child: const Text('save'),
                      )
                    ],
                  );
                },
                context: context);
          },
          icon: const Icon(
            Icons.edit,
            color: Colors.deepPurple,
          ),
        ),
        title: Text(result.name!),
        subtitle: Text(result.address!),
        trailing: InkWell(
          child: const Icon(
            Icons.remove_circle,
            color: Colors.red,
          ),
          onTap: () {
            ///Dleete method here
            box.deleteAt(index);
          },
        ),
      ),
    );
  }

  FloatingActionButton addButton(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => addNewBook(context),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      title: const Text("Hive DB"),
    );
  }

  void addNewBook(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("New Employee"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: name,
                  decoration: const InputDecoration(hintText: 'Name'),
                ),
                const SizedBox(
                  height: 15,
                ),
                TextFormField(
                  controller: address,
                  decoration: const InputDecoration(hintText: 'Address'),
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                  onPressed: () async {
                    await box.put(
                      DateTime.now().toString(),
                      EmployeeModel(
                        name: name.text,
                        address: address.text,
                      ),
                    );
                    clearController();
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context);
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
          );
        });
  }
}
