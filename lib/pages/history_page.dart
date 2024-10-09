import 'package:flutter/material.dart';
import 'package:t_polls_app/types/poll.dart';
import 'package:t_polls_app/widgets/history_card.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("История"),
      ),
      body: SingleChildScrollView(
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) => HistoryCard(
            poll: Poll(
                name: "Чайник электрический Поларис",
                desc: "чайник просто во !",
                questions: {
                  "Удобство использования": 2,
                  "Скорость закипания воды": 5,
                  "Дизайн": 4,
                },
                finalQuestion: 'Вас в целом устраивает работа чайника?'),
            finalQuestion: true,
          ),
          itemCount: 10,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
        ),
      ),
    );
  }
}
