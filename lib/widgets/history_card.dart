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
          child: Text(
            poll.name,
          ),
        ),
      ),
    );
  }
}
