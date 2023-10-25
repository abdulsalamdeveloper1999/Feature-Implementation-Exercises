import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import '../models/post_api/post_api.dart';

class BlocRepo {
  static Future<List<PostApi>> getApi() async {
    List<PostApi> postApiList = [];
    try {
      final res = await http.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      var data = jsonDecode(res.body.toString());
      if (res.statusCode == 200) {
        for (var i in data) {
          // log('data fetch');
          postApiList.add(PostApi.fromJson(i));
        }
      } else {
        log('error ${res.statusCode}');
      }
      return postApiList;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }
}
