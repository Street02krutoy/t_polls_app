import "package:flutter/material.dart";
import "package:t_polls_app/api/api_service.dart";
import "../types/poll.dart";
import "../widgets/poll_card.dart";

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  Future? polls;

  void fetch() async {
    polls = ApiService.service.getPolls();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   fetch();
  // }

  @override
  Widget build(BuildContext context) {
    fetch();
    print("AAAA");
    return FutureBuilder(
      future: polls,
      builder: (context, snapshot) {
        print(snapshot);
        if (snapshot.hasData) {
          List<Poll> pollsList = snapshot.data;
          return SingleChildScrollView(
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => PollCardWidget(
                poll: pollsList[index],
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
    );
  }
}
