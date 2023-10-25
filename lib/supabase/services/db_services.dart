import 'dart:developer';

import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tutorials_project/supabase/models/profile_model.dart';

import '../../componnets/custom_snackbar.dart';

class SupabaseServices {
  var client = Supabase.instance.client;
  String tableName = 'profiles';
  Future createUser({
    required String name,
    required String email,
  }) async {
    try {
      ProfileModel mdl = ProfileModel(
        employeeName: name,
        employeeEmail: email,
      );
      await client.from(tableName).insert([mdl.toMap()]);

      log('Data added');
    } catch (e) {
      log(e.toString());
    }
  }

  Future<List<ProfileModel>> fetchUserDataWithRetry() async {
    List<ProfileModel> pList = [];
    int maxAttempts = 3; // Set the maximum number of retry attempts
    int attempts = 0;

    while (attempts < maxAttempts) {
      try {
        PostgrestResponse response = await client.from(tableName).select();
        // var data = jsonDecode(response);
        if (response.data != null) {
          final data = response as List<Map<String, dynamic>>;
          log('Data fetched: $data');
          for (var element in data) {
            pList.add(ProfileModel.fromMap(element));
          }
          return pList;
        } else {
          log('Error while fetching data: Response is null');
          return [];
        }
      } catch (e) {
        log('Error ${e.toString()}');
        attempts++;
      }
    }
    return []; // Return empty list if all attempts fail
  }

  Future deleteData(context, id) async {
    try {
      await client.from(tableName).delete().eq('id', id);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future updateData(int id, String newName) async {
    try {
      await client.from(tableName).update({'name': newName}).eq(
        'id',
        id,
      ) // Specify the condition to match the row by its ID
          ;
    } catch (e) {
      // Handle any potential errors here
      log(e.toString());
    }
  }
}
