import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class SecurityQuestionsPage extends StatefulWidget {
  const SecurityQuestionsPage({super.key});

  @override
  State<SecurityQuestionsPage> createState() => _SecurityQuestionsPageState();
}

class _SecurityQuestionsPageState extends State<SecurityQuestionsPage> {
  late Future<List<String>> _questionsFuture;

  @override
  void initState() {
    super.initState();
    _questionsFuture = fetchSecurityQuestions();
  }

  Future<List<String>> fetchSecurityQuestions() async {
    final url = Uri.parse('https://39a791522f04.ngrok-free.app/WASIYYAH/api/v1/user/securityQuestionLis');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      if (data is List) {
        return data.map<String>((item) => item.toString()).toList();
      } else if (data is Map && data['questions'] is List) {
        return (data['questions'] as List).map<String>((item) => item.toString()).toList();
      } else {
        throw Exception('Unexpected response format');
      }
    } else {
      throw Exception('Failed to load security questions');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Security Questions')),
      body: FutureBuilder<List<String>>(
        future: _questionsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No security questions found.'));
          } else {
            final questions = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: questions.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(questions[index]),
                  leading: const Icon(Icons.security),
                  tileColor: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
              separatorBuilder: (_, __) => const SizedBox(height: 12),
            );
          }
        },
      ),
    );
  }
}