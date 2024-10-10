import 'package:flutter/material.dart';
import 'package:t_polls_app/types/poll.dart';
import 'package:t_polls_app/widgets/history_card.dart';

import '../api/api_service.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  Future? polls;

  void fetch() async {
    polls = ApiService.service.getHistories();
  }

  @override
  Widget build(BuildContext context) {
    fetch();
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
      ),
      body: FutureBuilder(
        future: polls,
        builder: (context, snapshot) {
          print(snapshot);
          if (snapshot.hasData) {
            List<Poll> pollsList = snapshot.data;
            return SingleChildScrollView(
              child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) => HistoryCard(
                  poll: pollsList[index]
                ),
                itemCount: pollsList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
