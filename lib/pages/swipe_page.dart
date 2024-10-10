import "package:flutter/material.dart";
import 'package:appinio_swiper/appinio_swiper.dart';
import "package:t_polls_app/api/api_service.dart";
import "../types/poll.dart";

class SwipePage extends StatefulWidget {
  const SwipePage({super.key});

  @override
  State<SwipePage> createState() => _SwipePageState();
}

class _SwipePageState extends State<SwipePage> {
  Future? poll;
  List<int> marks = [];

  void refresh([int previousId = -1]) {
    setState(() {
      poll = ApiService.service.getRandomPoll(previousId);
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: poll,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          Poll myPoll = snapshot.data;
          List<String> keys = [];
          for (var a in myPoll.questions!.keys) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 10),
                      child: Text(
                        myPoll.name,
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: buildSwiper(myPoll, keys, poll),
                ),
                const Spacer(),
                const Icon(
                  Icons.loop,
                  size: 40,
                  color: Colors.amberAccent,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Icon(
                  Icons.arrow_upward,
                  size: 30,
                ),
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
                const SizedBox(
                  height: 8,
                )
              ],
            ),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  AppinioSwiper buildSwiper(Poll p, List<String> keys, [args]) {
    return AppinioSwiper(
        cardCount: 4,
        backgroundCardCount: 0,
        backgroundCardScale: 0.1,
        maxAngle: 0,
        threshold: 20,
        swipeOptions:
            const SwipeOptions.only(up: true, right: true, left: true),
        onSwipeEnd:
            (int previousIndex, int targetIndex, SwiperActivity activity) {
          // print(targetIndex);
          if (previousIndex == targetIndex) return;
          if (activity.direction == AxisDirection.left) {
            // 1 star or no
          }
          if (activity.direction == AxisDirection.right) {
            // 5 star or yes
          }
          if (activity.direction == AxisDirection.up) {
            // skip
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
                        refresh(p.id);
                        Navigator.of(context).pop();
                        // initState();
                      },
                      child: const Text("ОК"))
                ],
              ),
            );
          }
        },
        cardBuilder: (BuildContext context, int index) {
          print("-----: $index");
          return SwipeQuestionCard(
            index: index,
            poll: p,
            keys: keys,
          );
        });
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
    var i = widget.index;
    print("++++: $i");
    return Card(
      child: Text(
        widget.index == 3
            ? widget.poll.finalQuestion!
            : widget.keys[i],
        style: const TextStyle(fontSize: 32),
        textAlign: TextAlign.center,
      ),
    );
  }
}
