import "package:flutter/material.dart";
import 'package:appinio_swiper/appinio_swiper.dart';
import "package:running_text/running_text.dart";
import "../types/poll.dart";
import "../widgets/poll_card.dart";

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  final Poll poll = Poll(
      name: "Чайник электрический Поларис",
      desc: "чайник просто во !",
      questions: {
        "Удобство использования": null,
        "Скорость закипания воды": null,
        "Дизайн": null,
      },
      finalQuestion: 'Вас в целом устраивает работа чайника?');

  int index = 0;

  @override
  Widget build(BuildContext context) {
    List<String> keys = [];
    for (var a in poll.questions.keys) {
      keys.add(a);
    }

    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10,
            ),
            child: Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                child: Text(
                  poll.name,
                  style: Theme.of(context).textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          const Spacer(),
          Expanded(
            child: AppinioSwiper(
              cardCount: 4,
              backgroundCardCount: 0,
              swipeOptions: const SwipeOptions.symmetric(horizontal: true),
              onSwipeEnd: (int previousIndex, int targetIndex,
                  SwiperActivity activity) {
                if (previousIndex == targetIndex) return;
                if (activity.direction == AxisDirection.left) {
                  // 1 star or no
                }
                if (activity.direction == AxisDirection.right) {
                  // 5 star or yes
                }
                if (targetIndex == 4) {
                  showDialog(
                    barrierDismissible: false,
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Спасибо за прохождение опроса!"),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text("ОК"))
                      ],
                    ),
                  );
                }
              },
              cardBuilder: (BuildContext context, int index) =>
                  SwipeQuestionCard(
                index: index,
                poll: poll,
                keys: keys,
              ),
            ),
          ),
          const SizedBox(height: 30,),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.close,
                color: Colors.red,
                size: 40,
              ),
              Icon(
                Icons.arrow_back,
                size: 30,
              ),
              Text(
                "Свайпай!",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Icon(
                Icons.arrow_forward,
                size: 30,
              ),
              Icon(
                Icons.done,
                color: Colors.green,
                size: 40,
              ),
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}

class SwipeQuestionCard extends StatefulWidget {
  const SwipeQuestionCard(
      {super.key, required this.index, required this.poll, required this.keys});

  final int index;
  final Poll poll;
  final List<String> keys;

  @override
  State<SwipeQuestionCard> createState() => _SwipeQuestionCardState();
}

class _SwipeQuestionCardState extends State<SwipeQuestionCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Center(
        child: Text(
          widget.index == 3
              ? widget.poll.finalQuestion
              : widget.keys[widget.index],
          style: const TextStyle(fontSize: 32),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
