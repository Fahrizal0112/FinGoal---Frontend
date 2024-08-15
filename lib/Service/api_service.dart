import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  final String baseUrl = 'http://192.168.18.29:8080/fingoal';

  Future<Map<String, dynamic>> signup(String lastname,String firstname,String username,String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signup'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'email': email,
        'password': password,
        'firstname': firstname,
        'lastname': lastname,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign up');
    }
  }

  Future<Map<String, dynamic>> signin(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/signin'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final token = data['token'];

      const storage = FlutterSecureStorage();
      await storage.write(key: 'authorization', value: token);
      debugPrint('Token saved: $token');
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to sign in');
    }
  }

  Future<List<Map<String, dynamic>>> getQuestions() async {
    final response = await http.get(
      Uri.parse('$baseUrl/question'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load questions');
    }
  }


  Future<Map<String, dynamic>> getLastname() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authorization');
    debugPrint('Token: $token');
    if (token == null) {
      throw Exception('Token not found');
    }

    final uri = Uri.parse('$baseUrl/lastname');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'authorization=$token', 
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load lastname');
    }
  }

  Future<Map<String, dynamic>> getRisk() async {
    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'authorization');
    if (token == null) {
      throw Exception('Token Not Found');
    }
    final uri = Uri.parse('$baseUrl/risk');
    final response = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'authorization=$token', 
      }
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load risk');
    }
  }

  Future<List<Map<String, dynamic>>> getAnswersByQuestionId(String questionId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/answer/$questionId'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load answers');
    }
  }


  Future<Map<String, dynamic>> createAnswer(String questionId, String answer) async {
    final response = await http.post(
      Uri.parse('$baseUrl/answer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'questionId': questionId,
        'answer': answer,
      }),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create answer');
    }
  }

Future<Map<String, dynamic>> submitAnswers(List<Map<String, dynamic>> answers) async {
  const storage = FlutterSecureStorage();
  final token = await storage.read(key: 'authorization');

  if (token == null) {
    throw Exception('Token not found');
  }

  final response = await http.post(
    Uri.parse('$baseUrl/submit'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'answers': answers}),
  );

  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed to submit answers');
  }
}

  Future<Map<String, dynamic>> createSavings(String token, Map<String, dynamic> savingsData) async {
    final response = await http.post(
      Uri.parse('$baseUrl/saving'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': 'authorization=$token', 
      },
      body: jsonEncode(savingsData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create savings');
    }
  }
}