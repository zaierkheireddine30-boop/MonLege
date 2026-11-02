import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final String subjectName;
  final String trimesterName;

  const QuizScreen({super.key, required this.subjectName, required this.trimesterName});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int? _selectedAnswerIndex;
  int _score = 0;
  bool _isAnswered = false;

  final List<Map<String, dynamic>> _questions = [
    {
      'question': 'السؤال الأول: ما هي النتيجة الصحيحة للعملية المقترحة في الدرس؟',
      'answers': ['النتيجة أ هي الصحيحة', 'النتيجة ب هي الصحيحة', 'النتيجة ج هي الصحيحة'],
      'correctIndex': 0,
    },
    {
      'question': 'السؤال الثاني: حدد المفهوم المطابق للقاعدة المدرجة بالمحور.',
      'answers': ['المفهوم الأول', 'المفهوم الثاني', 'المفهوم الثالث'],
      'correctIndex': 1,
    }
  ];

  void _checkAnswer(int index) {
    if (_isAnswered) return;
    setState(() {
      _selectedAnswerIndex = index;
      _isAnswered = true;
      if (index == _questions[_currentQuestionIndex]['correctIndex']) {
        _score++;
      }
    });
  }

  void _nextQuestion() {
    setState(() {
      if (_currentQuestionIndex < _questions.length - 1) {
        _currentQuestionIndex++;
        _selectedAnswerIndex = null;
        _isAnswered = false;
      } else {
        _showResultsDialog();
      }
    });
  }

  void _showResultsDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E1E22),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('🎉 أحسنت! أكملت الاختبار', textAlign: TextAlign.center, style: TextStyle(color: Colors.white)),
        content: Text('لقد حصلت على $_score من ${_questions.length}', textAlign: TextAlign.center, style: const TextStyle(color: Colors.grey, fontSize: 16)),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Ferme la boîte de dialogue
              Navigator.pop(context); // Retourne au menu
            },
            child: const Text('ممتاز', style: TextStyle(color: Color(0xFF8B5CF6), fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      backgroundColor: const Color(0xFF0B0B0C),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Text(widget.subjectName, style: const TextStyle(color: Colors.grey, fontSize: 13, fontFamily: 'sans-serif')),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('السؤال ${_currentQuestionIndex + 1}/${_questions.length}', textAlign: TextAlign.right, style: const TextStyle(color: Color(0xFF06B6D4), fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              Text(currentQuestion['question'], textAlign: TextAlign.right, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 32),
              ...List.generate(currentQuestion['answers'].length, (index) {
                Color btnColor = const Color(0xFF1E1E22);
                if (_isAnswered) {
                  if (index == currentQuestion['correctIndex']) btnColor = const Color(0xFF10B981).withOpacity(0.2);
                  if (index == _selectedAnswerIndex && index != currentQuestion['correctIndex']) btnColor = const Color(0xFFEF4444).withOpacity(0.2);
                }
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 60,
                  child: ElevatedButton(
                    onPressed: () => _checkAnswer(index),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: btnColor,
                      elevation: 0,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: BorderSide(color: _selectedAnswerIndex == index ? const Color(0xFF8B5CF6) : Colors.white10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(currentQuestion['answers'][index], style: const TextStyle(color: Colors.white, fontSize: 14)),
                      ],
                    ),
                  ),
                );
              }),
              const Spacer(),
              if (_isAnswered)
                SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: _nextQuestion,
                    style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF8B5CF6), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26))),
                    child: const Text('السؤال التالي', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
