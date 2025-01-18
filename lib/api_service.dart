import 'dart:convert';
import 'package:http/http.dart' as http;
import 'question.dart';

class ApiService {
  final String apiUrl = 'https://api.jsonserve.com/Uw5CrX';

  // Fallback questions
  final List<Question> fallbackQuestions = [
    Question(
      question: "What is the capital of France?",
      options: ["Paris", "London", "Berlin", "Madrid"],
      answer: "Paris",
    ),
    Question(
      question: "What is 5 + 3?",
      options: ["5", "8", "12", "15"],
      answer: "8",
    ),
    Question(
      question: "Who wrote 'Romeo and Juliet'?",
      options: [
        "William Shakespeare",
        "Charles Dickens",
        "J.K. Rowling",
        "Leo Tolstoy"
      ],
      answer: "William Shakespeare",
    ),
  ];

  Future<List<Question>> fetchQuizData() async {
    try {
      final response = await http.get(Uri.parse(apiUrl));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return (data as List).map((json) => Question.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load data: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching quiz data: $error');
      print('Using fallback questions instead.');
      return fallbackQuestions; // Use fallback questions if API fails
    }
  }
}
