import 'package:flutter/material.dart';
import 'package:t_polls_app/pages/poll_page.dart';
import 'package:t_polls_app/types/poll.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard(
      {super.key, required this.poll, required this.finalQuestion});

  final Poll poll;
  final bool finalQuestion;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => PollPage(
                  poll: poll,
                  lock: true,
                  finalQuestion: true,
                )));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  const Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text("Описание"),
                              content: Text(poll.desc),
                              actions: [
                                TextButton(onPressed: () {
                                  Navigator.of(context).pop();
                                }, child: Text("OK"))
                              ],
                            );
                          });
                    },
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      child: Icon(
                        size: 15,
                        Icons.info,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  )
                ],
              ),
              const Spacer(),
              Center(
                child: Text(
                  poll.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              const Spacer(
                flex: 2,
              )
            ],
          ),
        ),
      ),
    );
  }
}
