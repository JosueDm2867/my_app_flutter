import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'API Ejemplo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ApiExampleScreen(),
    );
  }
}

class ApiExampleScreen extends StatefulWidget {
  const ApiExampleScreen({super.key});

  @override
  State<ApiExampleScreen> createState() => _ApiExampleScreenState();
}

class _ApiExampleScreenState extends State<ApiExampleScreen> {
  Map<String, dynamic>? users; 

  @override
  void initState() {
    super.initState();
    fetchUsers(); // Llamada a la API 
  }

  Future<void> fetchUsers() async {
    final url = Uri.parse('https://jsonplaceholder.typicode.com/users/5');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          users = data;
        });
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Ocurrió un error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: const Text(
              'JSONPlaceholder Users',
              style: TextStyle(
                color:  Colors.white,
              )
          ),
        ),
        backgroundColor: Colors.blue,
      ),
      body: users == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Nombre User: ${users!['name']}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'Titulo: ${users!['phone']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Completado: ${users!['website']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
