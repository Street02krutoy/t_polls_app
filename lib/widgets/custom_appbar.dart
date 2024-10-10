import 'package:flutter/material.dart';
import 'package:running_text/running_text.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: text.length > 20
          ? RunningTextView(
              data: RunningTextModel(
                [text],
                textStyle: Theme.of(context).appBarTheme.titleTextStyle,
                softWrap: true,
                velocity: 50,
                direction: RunningTextDirection.rightToLeft,
                fadeSide: RunningTextFadeSide.both,
              ),
            )
          : Text(text),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
