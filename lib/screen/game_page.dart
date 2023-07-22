import 'package:flutter/material.dart';
import '../route/route.dart';

class QuizGame extends StatefulWidget {
  const QuizGame({super.key});

  @override
  QuizGameState createState() => QuizGameState();
}

class QuizGameState extends State<QuizGame> {
  final List<String> questions = [
    'What is the national sport of India?',
    'Which country won the FIFA World Cup in 2022?',
    'Who holds the record for the most home runs in Major League Baseball?',
    'Who is considered the G.O.A.T (Greatest of All Time) in football?',
    'Which country hosted the 2016 Summer Olympics?',
    'In which sport can you perform a slam dunk?',
    'Which tennis player has won the most Grand Slam singles titles?',
    'Who won the 2021 NBA Finals?',
    'Which team has won the most Super Bowl championships in NFL history?',
    'What is the nickname of the New York Yankees baseball team?',
    'Who is the all-time leading scorer in NBA history?',
  ];

  final List<List<String>> options = [
    ['Cricket', 'Football', 'Hockey', 'Badminton'],
    ['Brazil', 'Germany', 'France', 'Argentina'],
    ['Babe Ruth', 'Barry Bonds', 'Hank Aaron', 'Alex Rodriguez'],
    ['Messi', 'Maradona', 'Ronaldo', 'CR'],
    ['Brazil', 'Japan', 'United States', 'Russia'],
    ['Basketball', 'Football', 'Tennis', 'Swimming'],
    ['Serena Williams', 'Venus Williams', 'Margaret Court', 'Steffi Graf'],
    ['Milwaukee Bucks', 'Phoenix Suns', 'Golden State Warriors', 'Los Angeles Lakers'],
    ['New England Patriots', 'Pittsburgh Steelers', 'Green Bay Packers', 'Dallas Cowboys'],
    ['Bronx Bombers', 'Red Sox', 'Mets', 'Cubs'],
    ['Kareem Abdul-Jabbar', 'LeBron James', 'Michael Jordan', 'Kobe Bryant'],
  ];

  final List<int> answers = [0, 3, 1, 0, 2, 0, 0, 1, 1, 0, 0];


  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(int selectedIndex) {
    if (selectedIndex == answers[currentQuestionIndex]) {
      setState(() {
        score++;
      });
    }

    goToNextQuestion();
  }

  void goToNextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showResultDialog();
    }
  }

  void showResultDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Quiz Completed'),
        content: Text('Your score: $score / ${questions.length}'),
        actions: [
          TextButton(
            onPressed: () {
              resetQuiz();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  void resetQuiz() {
    setState(() {
      Navigator.pop(context);
      currentQuestionIndex = 0;
      score = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).popAndPushNamed(homePage),
        ),
        title: const Text('Sports Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1}/${questions.length}',
              style: const TextStyle(fontSize: 18.0),
            ),
            const SizedBox(height: 8.0),
            Text(
              questions[currentQuestionIndex],
              style: const TextStyle(fontSize: 20.0),
            ),
            const SizedBox(height: 16.0),
            ...options[currentQuestionIndex].asMap().entries.map(
                  (entry) => ElevatedButton(
                onPressed: () => checkAnswer(entry.key),
                child: Text(entry.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

