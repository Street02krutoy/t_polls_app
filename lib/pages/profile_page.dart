import 'package:flutter/material.dart';
import 'package:t_polls_app/pages/history_page.dart';
import 'package:t_polls_app/pages/settings_page.dart';
import 'package:t_polls_app/widgets/custom_card.dart';
import 'package:t_polls_app/widgets/profile_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: CustomCard(
                  title: ClipOval(
                    child: CircleAvatar(
                      child: Image.network(
                          "https://klike.net/uploads/posts/2020-04/1586332729_34.jpg"),
                      radius: 60,
                      backgroundColor: Theme.of(context).canvasColor,
                    ),
                  ),
                  content: Text(
                    "error",
                    textScaler: TextScaler.linear(2),
                  ),
                ),
              ),
              Expanded(
                child: CustomCard(
                  title: Text(
                    "profile.rating",
                    style: Theme.of(context).textTheme.bodyLarge,
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
                    builder: (context) => const SettingsPage()));
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
