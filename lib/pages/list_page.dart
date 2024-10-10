import "package:flutter/material.dart";
import "../types/poll.dart";
import "../widgets/poll_card.dart";


class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
    );
  }
}
