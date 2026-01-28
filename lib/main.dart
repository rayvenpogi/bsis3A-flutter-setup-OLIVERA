import 'package:flutter/material.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Coffee Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF2C3E50),
        scaffoldBackgroundColor: const Color(0xFFECF0F1),
      ),
      home: const QuizScreen(),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  String view = 'start';
  int score = 0;
  int currentQuestionIndex = 0;
  bool answered = false;
  int? selectedAnswer;

  final List<Map<String, dynamic>> questions = [
    {
      'question':
          'Which feature would help Aling Nena’s Sari-Sari Store manage daily stock more efficiently?',
      'answers': [
        'Social media profile',
        'Inventory alert system',
        'Music player',
        'Video calling',
      ],
      'correctAnswer': 1,
    },
    {
      'question':
          'Which feature would help a local Barber Shop handle long customer wait times?',
      'answers': [
        'Digital queue number',
        'Photo filters',
        'News feed',
        'Game center',
      ],
      'correctAnswer': 0,
    },
    {
      'question':
          'Which feature would help a Small Cafe get more orders during the rainy season?',
      'answers': [
        'Map directions',
        'Delivery request system',
        'Calendar sync',
        'Battery optimizer',
      ],
      'correctAnswer': 1,
    },
    {
      'question':
          'Which feature would help a Local Dental Clinic remind patients of their scheduled visits?',
      'answers': [
        'Automated SMS/In-app reminders',
        'Wallpaper gallery',
        'Currency converter',
        'Built-in calculator',
      ],
      'correctAnswer': 0,
    },
    {
      'question':
          'Which feature would help a Mini-Grocery know which products their customers want more of?',
      'answers': [
        'Digital feedback form',
        'QR code scanner',
        'Language translator',
        'Dark mode toggle',
      ],
      'correctAnswer': 0,
    },
  ];

  Map<String, dynamic> get currentQuestion => questions[currentQuestionIndex];

  void startQuiz() {
    setState(() {
      view = 'quiz';
      score = 0;
      currentQuestionIndex = 0;
      answered = false;
      selectedAnswer = null;
    });
  }

  void selectAnswer(int index) {
    if (answered) return;
    setState(() {
      selectedAnswer = index;
      answered = true;
      if (index == currentQuestion['correctAnswer']) {
        score++;
      }
    });
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        answered = false;
        selectedAnswer = null;
      } else {
        view = 'end';
      }
    });
  }

  void restartQuiz() {
    setState(() {
      view = 'start';
      score = 0;
      currentQuestionIndex = 0;
      answered = false;
      selectedAnswer = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/bg.gif'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(color: const Color(0xFF2C3E50).withOpacity(0.5)),
          SafeArea(
            child: Center(
              child: view == 'start'
                  ? buildStartView()
                  : view == 'quiz'
                  ? buildQuizView()
                  : buildEndView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildStartView() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/quiz-time.gif', width: 400, height: 400),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: startQuiz,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 169, 218, 113),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Start Quiz',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildQuizView() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Question ${currentQuestionIndex + 1} of ${questions.length}',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Color(0xFFC8E6C9)),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFF81C784), width: 2),
            ),
            child: Text(
              currentQuestion['question'],
              style: const TextStyle(
                fontSize: 20,
                color: Color(0xFF1B5E20),
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ...List.generate(
            4,
            (index) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: buildAnswerButton(index),
            ),
          ),
          const SizedBox(height: 16),
          if (answered)
            ElevatedButton(
              onPressed: nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF2E7D32),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Next',
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            ),
        ],
      ),
    );
  }

  Widget buildAnswerButton(int index) {
    bool isSelected = selectedAnswer == index;
    bool isCorrect = index == currentQuestion['correctAnswer'];

    Color bgColor() {
      if (!answered) return Colors.white.withOpacity(0.8);
      if (isCorrect) return const Color(0xFF66BB6A).withOpacity(0.8);
      if (isSelected) return const Color(0xFFEF5350).withOpacity(0.8);
      return Colors.white.withOpacity(0.5);
    }

    Color borderColor() {
      if (!answered) return const Color(0xFFA5D6A7);
      if (isCorrect) return const Color(0xFF1B5E20);
      if (isSelected) return Colors.redAccent;
      return const Color(0xFFA5D6A7);
    }

    return InkWell(
      onTap: answered ? null : () => selectAnswer(index),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor(),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: borderColor(), width: 2),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: borderColor(),
              child: Text(
                String.fromCharCode(65 + index),
                style: const TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                currentQuestion['answers'][index],
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF1B5E20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildEndView() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'You Nailed It!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 230, 255, 120),
            ),
          ),
          Image.asset(
            'assets/congrats.gif',
            width: double.infinity,
            height: 200,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 20),
          const Text(
            'Score:',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
            ),
          ),
          Text(
            '$score / ${questions.length}',
            style: const TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: restartQuiz,
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 169, 218, 113),
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Try Again?',
              style: TextStyle(fontSize: 18, color: Color(0xFF2C3E50)),
            ),
          ),
        ],
      ),
    );
  }
}
