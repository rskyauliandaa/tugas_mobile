import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> todos = [];
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/todos/');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        todos = jsonDecode(response.body);
      });
    } else {
      print("Error: ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Tugas Integrasi Data"),
        ),
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                leading:
                    CircleAvatar(child: Text((todos[index]['id']).toString())),
                title: Row(
                  children: [
                    Expanded(child: Text(todos[index]['title'])),
                    Row(
                      children: [
                        const Icon(Icons.person),
                        Text((todos[index]['userId']).toString()),
                      ],
                    ),
                  ],
                ),
                subtitle: Text(
                  todos[index]['completed'] ? "Completed" : "Not Completed",
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
