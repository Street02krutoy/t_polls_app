import 'package:flutter/material.dart';
import 'package:t_polls_app/pages/history_page.dart';
import 'package:t_polls_app/pages/settings_page.dart';
import 'package:t_polls_app/widgets/custom_card.dart';
import 'package:t_polls_app/widgets/profile_button.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.refreshParent});

  final Function refreshParent;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Профиль"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  title: ClipOval(
                    child: CircleAvatar(
                      radius: 60,
                      backgroundColor: Theme.of(context).canvasColor,
                      child: const Icon(
                        Icons.account_circle_outlined,
                        size: 120,
                      ),
                    ),
                  ),
                  content: Text(
                    TelegramWebApp.instance.initData.user.firstname ?? "User",
                    textScaler: const TextScaler.linear(2),
                  ),
                ),
              ),
              Expanded(
                child: CustomCard(
                  title: Text(
                    "Опросов пройдено:",
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  content: Text(
                    "52",
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  height: 160,
                ),
              )
            ],
          ),
          Expanded(
            child: ProfileButtonWidget(
              title: const Text("История"),
              icon: Icons.history,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const HistoryPage()));
              },
            ),
          ),
          Expanded(
            child: ProfileButtonWidget(
              title: const Text("Настройки"),
              icon: Icons.settings,
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SettingsPage(
                          refreshParent: widget.refreshParent,
                        )));
              },
            ),
          ),
          Expanded(
            child: ProfileButtonWidget(
              title: const Text("Тех. поддержка"),
              icon: Icons.support,
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}
