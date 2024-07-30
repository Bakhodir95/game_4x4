import 'package:flutter/material.dart';
import 'package:lesson85/models/quiz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lesson85/bloc/quiz_bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';

// ignore: must_be_immutable
class QuizScreen extends StatefulWidget {
  final Quiz quiz;
  final List<String> guessedLetters;

  const QuizScreen({
    super.key,
    required this.quiz,
    required this.guessedLetters,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<QuizBloc>(context);

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 27, 20, 249),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemCount: widget.quiz.images.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Image.network(
                        widget.quiz.images[index],
                      ),
                    );
                  },
                ),
              ),
              const Spacer(),
              Wrap(
                children: widget.quiz.correctAnswer.split('').map((letter) {
                  return Container(
                    width: 60,
                    padding: const EdgeInsets.all(5),
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.green),
                    ),
                    child: Text(
                      widget.guessedLetters.contains(letter) ? letter : ' ',
                      style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
              const Spacer(),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisSpacing: 40,
                    mainAxisSpacing: 40,
                    crossAxisCount: 5,
                  ),
                  itemCount: widget.quiz.hint.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        bloc.add(SubmitAnswer(widget.quiz.hint[index]));
                      },
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          widget.quiz.hint[index],
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 40,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
