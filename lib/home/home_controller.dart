import 'package:DevQuiz/core/app_images.dart';
import 'package:DevQuiz/home/home_repository.dart';
import 'package:DevQuiz/home/home_state.dart';
import 'package:DevQuiz/shared/models/awnser_model.dart';
import 'package:DevQuiz/shared/models/question_model.dart';
import 'package:DevQuiz/shared/models/quiz_model.dart';
import 'package:DevQuiz/shared/models/user_model.dart';
import 'package:flutter/cupertino.dart';

class HomeController {
//USER
//QUIZZES

  final stateNotifier = ValueNotifier<HomeState>(HomeState.empty);
  set state(HomeState state) => stateNotifier.value = state;
  HomeState get state => stateNotifier.value;

  UserModel? user;
  List<QuizModel>? quizzes;

  final repository = HomeRepository();

  void getUser() async {
    state = HomeState.loading;
    Future.delayed(const Duration(seconds: 10));
    user = await Future.any([
      Future.value(repository.getUser()).timeout(const Duration(seconds: 6))
    ]);
    state = HomeState.success;
  }

  void getQuizzes() async {
    state = HomeState.loading;
    quizzes = await Future.any([
      Future.value(repository.getQuizzes()).timeout(const Duration(seconds: 6))
    ]);
    state = HomeState.success;
  }
}
