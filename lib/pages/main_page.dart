import 'package:flutter/material.dart';
import 'package:t_polls_app/pages/profile_page.dart';
import 'package:t_polls_app/types/poll.dart';
import 'package:t_polls_app/widgets/poll_card.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Theme.of(context).colorScheme.secondary,
              child: Icon(
                size: 25,
                Icons.account_circle,
                color: Theme.of(context).primaryColor,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: const Text("username"),
            )
          ],
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()));
            },
            icon: const Icon(Icons.account_circle),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => PollCardWidget(
            poll: Poll(
                name: "Чайник электрический Поларис",
                desc: "чайник просто во !",
                questions: {
                  "Удобство использования": null,
                  "Скорость закипания воды": null,
                  "Дизайн": null,
                },
                finalQuestion: 'Вас в целом устраивает работа чайника?'),
          ),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      ),
    );
  }
}
