import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void saveData() async {
    var url = Uri.parse(
        'https://database-http-4d0d2-default-rtdb.firebaseio.com/data.json');
    var response = await http.post(url,
        body: jsonEncode({
          'name': 'Hasib',
          'age': 12,
          'sex': 'male',
          'address': 'fake address..',
          'isTrue': false,
        }));
    print(response.statusCode);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () => {saveData()},
            child: const Text('Send Data.'),
          ),
        ),
      ),
    );
  }
}
