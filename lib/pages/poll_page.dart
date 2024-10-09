import 'package:flutter/material.dart';
import 'package:running_text/running_text.dart';
import 'package:t_polls_app/pages/main_page.dart';
import 'package:t_polls_app/types/poll.dart';
import 'package:t_polls_app/widgets/question_card.dart';

class PollPage extends StatefulWidget {
  const PollPage(
      {super.key, required this.poll, required this.lock, this.finalQuestion});

  final Poll poll;

  final bool lock;
  final bool? finalQuestion;

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  late final QuestionController _questionController;

  @override
  void initState() {
    super.initState();
    _questionController = QuestionController(questions: widget.poll.questions);
    widget.finalQuestion == null
        ? null
        : _questionController.setFinalQuestion(widget.finalQuestion!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: RunningTextView(
            data: RunningTextModel(
          [widget.poll.name],
          textStyle: Theme.of(context).appBarTheme.titleTextStyle,
          softWrap: false,
          velocity: 50,
          direction: RunningTextDirection.rightToLeft,
          fadeSide: RunningTextFadeSide.both,
        )),
      ),
      body: Center(
        child: Column(
          children: [
            ListView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: QuestionCardWidget(
                          controller: _questionController,
                          question: widget.poll.questions.keys.elementAt(index),
                          lock: widget.lock,
                        ),
                      ),
                    ),
                itemCount: widget.poll.questions.length),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        widget.poll.finalQuestion,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Spacer(
                            flex: 2,
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  // backgroundColor: Colors.green,
                                  side: BorderSide(
                                      width:
                                          _questionController.finalQuestion ==
                                                  true
                                              ? 5
                                              : 2,
                                      color: Colors.green)),
                              onPressed: widget.lock
                                  ? null
                                  : () {
                                      setState(() {
                                        _questionController
                                            .setFinalQuestion(true);
                                      });
                                    },
                              child: Text(
                                "Да",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                          const Spacer(
                            flex: 1,
                          ),
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  // backgroundColor: Colors.red,
                                  side: BorderSide(
                                      width:
                                          _questionController.finalQuestion ==
                                                  false
                                              ? 5
                                              : 2,
                                      color: Colors.red)),
                              onPressed: widget.lock
                                  ? null
                                  : () {
                                      setState(() {
                                        _questionController
                                            .setFinalQuestion(false);
                                      });
                                    },
                              child: Text(
                                "Нет",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor),
                              )),
                          const Spacer(
                            flex: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),
            widget.lock == true
                ? const Row()
                : Row(
                    children: [
                      Expanded(
                          child: ElevatedButton(
                              onPressed: _questionController.answered
                                  ? () {
                                      print(_questionController);
                                      showDialog(
                                          barrierDismissible: false,
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: const Text(
                                                    "спасибо за прохождение опроса!"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () => Navigator
                                                              .of(context)
                                                          .pushAndRemoveUntil(
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          const MainPage()),
                                                              (r) => false),
                                                      child: const Text("ok"))
                                                ],
                                              ));
                                    }
                                  : null,
                              child: const Text("otpravit"))),
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
