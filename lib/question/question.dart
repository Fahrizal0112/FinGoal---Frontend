import 'package:fingoal_frontend/Service/api_service.dart';
import 'package:fingoal_frontend/menu.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class Question extends StatefulWidget {
  const Question({super.key});
  @override
  State<Question> createState() {
    return _QuestionState();
  }
}

class _QuestionState extends State<Question> {
  Future<List<Map<String, dynamic>>>? questions;
  final _pageController = PageController();
  int _currentPage = 0;
  String _currentQuestionId = '1';
  final List<Map<String, dynamic>> _answers = [];

  @override
  void initState() {
    super.initState();
    questions = ApiService().getQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 45, 45, 45),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: questions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(child: Text('No questions available'));
          } else {
            final questions = snapshot.data!;

            return Column(
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                    const SizedBox(width: 10),
                    Text(
                      "Profile Risk Question",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                Center(
                  child: Lottie.asset(
                    'assets/animation/Animation - 1723270379432.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.cover,
                    frameRate: const FrameRate(60),
                  ),
                ),
                Expanded(
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                        _currentQuestionId = questions[index]['id'].toString();
                      });
                    },
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      final questionData = questions[index];
                      final questionText = questionData['questionText'];

                      return FutureBuilder<List<Map<String, dynamic>>>(
                        future: ApiService()
                            .getAnswersByQuestionId(_currentQuestionId),
                        builder: (context, answerSnapshot) {
                          if (answerSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (answerSnapshot.hasError) {
                            return Center(
                                child: Text('Error: ${answerSnapshot.error}'));
                          } else if (!answerSnapshot.hasData ||
                              answerSnapshot.data == null ||
                              answerSnapshot.data!.isEmpty) {
                            return const Center(
                                child: Text('No answers available'));
                          } else {
                            final answers = answerSnapshot.data!;

                            return _buildQuestionPage(
                              question: questionText,
                              answers: answers,
                              totalQuestions: questions.length,
                              currentPage: _currentPage,
                              questionId: questions[index]['id'].toString(),
                            );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildQuestionPage({
    required String question,
    required List<Map<String, dynamic>> answers,
    required int totalQuestions,
    required int currentPage,
    required String questionId,
  }) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Question ${currentPage + 1} of $totalQuestions",
            style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
          ),
          const SizedBox(height: 20),
          Text(
            question,
            style: GoogleFonts.poppins(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView(
              children: answers.map((answer) {
                final answerText = answer['answerText'];
                final answerId =
                    answer['id']; 
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 46, 139, 87),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    onPressed: () {
                      debugPrint(
                          'Selected answer: $answerText with id: $answerId');

                      _answers.add({
                        'questionId': int.parse(questionId),
                        'answerId': answerId,
                      });

                      if (currentPage < totalQuestions - 1) {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      } else {
                        _submitAnswers();
                      }
                    },
                    child: Text(
                      answerText,
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontSize: 12),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submitAnswers() async {
    try {
      final response = await ApiService().submitAnswers(_answers);
      debugPrint('Answers submitted successfully: $response');
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const Menu())); 
    } catch (e) {
      debugPrint('Error submitting answers: $e');
    }
  }
}
