import 'package:DevQuiz/challenge/challenge_controller.dart';
import 'package:flutter/material.dart';

import 'package:DevQuiz/challenge/widgets/next_button/next_button_widget.dart';
import 'package:DevQuiz/challenge/widgets/question_indicator/question_indicator_widget.dart';
import 'package:DevQuiz/challenge/widgets/quiz/quiz_widget.dart';
import 'package:DevQuiz/shared/models/question_model.dart';

class ChallengePage extends StatefulWidget {
  final List<QuestionModel> questions;
  const ChallengePage({
    Key? key,
    required this.questions,
  }) : super(key: key);
  @override
  _ChallengePageState createState() => _ChallengePageState();
}

class _ChallengePageState extends State<ChallengePage> {
  final controller = ChallengeController();
  final pageController = PageController();

  @override
  void initState() {
    pageController.addListener(() {
      controller.currentPage = pageController.page!.toInt() + 1;
      setState(() {
        
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(86),
        child: SafeArea(
          top: true,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.close),
              ),
              ValueListenableBuilder<int>(
                valueListenable: controller.currentPageNotifier,
                
                builder: (context, value, _) => QuestionIndicatorWidget(
                  currentPage: value,
                  length: widget.questions.length,
                ),
                
              ),
            ],
          ),
        ),
      ),
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: widget.questions.map((e) => QuizWidget(question: e)).toList(),
      ),
      bottomNavigationBar: SafeArea(
        bottom: true,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                  child: NextButtonWidget.white(
                label: "Pular",
                onTap: () {
                  pageController.nextPage(
                      duration: Duration(milliseconds: 10), curve: Curves.linear,);
                },
              )),
              SizedBox(
                width: 7,
              ),
              Expanded(
                  child: NextButtonWidget.green(
                label: "Confirmar",
                onTap: () {},
              )),
            ],
          ),
        ),
      ),
    );
  }
}
