import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_database/profile.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<Profile> futureProfile;
  String receivedData = '';
  void saveData() async {
    var url = Uri.parse(
        'https://database-http-4d0d2-default-rtdb.firebaseio.com/data.json');
    var response = await http.post(url,
        body: jsonEncode({
          'name': 'Hasib',
          'age': 12,
          'address': 'fake address..',
        }));
    print(response.statusCode);
  }

  @override
  void initState() {
    super.initState();
    futureProfile = fetchDataFuture();
  }

  Future<Profile> fetchData() async {
    var url = Uri.parse(
        'https://database-http-4d0d2-default-rtdb.firebaseio.com/data.json');
    var response = await http.get(
      url,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  Future<Profile> fetchDataFuture() async {
    var url = Uri.parse(
        'https://database-http-4d0d2-default-rtdb.firebaseio.com/data/-MvXrVHlTUAmkVpZEK1s.json');
    var response = await http.get(
      url,
    );
    print(response.statusCode);
    print(response.body);
    if (response.statusCode == 200) {
      return Profile.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load data.');
    }
  }

  void reloadData() {
    setState(() {
      futureProfile = fetchDataFuture();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => {saveData()},
                child: const Text('Send Data.'),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => {reloadData()},
                child: const Text('Reload data'),
              ),
              const SizedBox(height: 40),
              FutureBuilder(
                future: fetchDataFuture(),
                // initialData: InitialData,
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Text((snapshot.data as Profile).name),
                        Text((snapshot.data as Profile).address),
                        Text((snapshot.data as Profile).age.toString()),
                      ],
                    );
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
