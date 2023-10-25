import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/books_model.dart';

class NodeApiScreen extends StatefulWidget {
  const NodeApiScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _NodeApiScreenState createState() => _NodeApiScreenState();
}

class _NodeApiScreenState extends State<NodeApiScreen> {
  List<Book> _books = [];
  bool _isLoading = true;
  String _error = '';

  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

  Future<void> _fetchBooks() async {
    try {
      final response = await http.get(
        Uri.parse('http://192.168.100.9:3000/api/books'),
      );
      if (response.statusCode == 200) {
        log(response.statusCode.toString());
        final List<dynamic> json = jsonDecode(response.body);
        setState(() {
          _books = json.map((item) => Book.fromJson(item)).toList();
          _isLoading = false;
        });
      } else {
        throw Exception('Failed to load books');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _error =
            'Failed to fetch data. Check your internet connection or server availability.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Books'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _error.isNotEmpty
              ? Center(child: Text(_error))
              : ListView.builder(
                  itemCount: _books.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text(_books[index].title),
                      subtitle: Text(_books[index].author),
                    );
                  },
                ),
    );
  }
}
