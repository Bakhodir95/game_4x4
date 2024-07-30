import 'package:bloc/bloc.dart';
import 'package:lesson85/bloc/quiz_event.dart';
import 'package:lesson85/bloc/quiz_state.dart';
import 'package:lesson85/models/quiz.dart';

class QuizBloc extends Bloc<QuizBlocEvent, QuizBlocState> {
  List<Quiz> quizzes = [
    Quiz(
      images: [
        "https://cdn.britannica.com/13/91613-131-769F969B/island-ocean-floor-South-Pacific.jpg",
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwTU7BrQw4LFwyfebaf7VT_Xb-T9bGz8eOog&s",
        "https://media.cnn.com/api/v1/images/stellar/prod/180219103122-zanzibar-and-its-islands-mnemba-a-view-from-the-sky-mnemba-island-lodge.jpg?q=w_1600,h_900,x_0,y_0,c_fill/h_447",
        "https://hips.hearstapps.com/hmg-prod/images/the-amazing-aerial-view-of-the-paradise-bora-bora-royalty-free-image-1620658687.",
      ],
      hint: ["i", "d", "s", "l", "a", "n", "d", "d", "p", "t"],
      correctAnswer: "island",
    ),
  ];

  QuizBloc() : super(QuizBlocInitial()) {
    on<FirsQuizEvent>((event, emit) {
      emit(QuizQuestion(quiz: quizzes[0], guessedLetters: []));
    });

    on<SubmitAnswer>((event, emit) {
      final currentState = state;
      if (currentState is QuizQuestion) {
        // Compare guessed letter with correct answer
        final guess = event.answer;
        final correctAnswer = currentState.quiz.correctAnswer;
        final guessedLetters = List<String>.from(currentState.guessedLetters);

        if (correctAnswer.contains(guess)) {
          guessedLetters.add(guess);
          emit(QuizQuestion(
              quiz: currentState.quiz, guessedLetters: guessedLetters));
        } else {
          emit(AnswerWrong());
          emit(QuizQuestion(
              quiz: currentState.quiz, guessedLetters: guessedLetters));
        }

        // Check if all letters are guessed
        if (guessedLetters.toSet().containsAll(correctAnswer.split(''))) {
          emit(QuizComplete());
        }
      }
    });

    on<NextQuestion>((event, emit) {
      emit(QuizBlocInitial());
    });
  }
}
