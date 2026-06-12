import 'package:flutter/material.dart';
import 'package:xinyue/l10n/app_localizations.dart';
import 'package:xinyue/layout/bottom_tab_page.dart';
import 'package:xinyue/page/mall/mall_page.dart';
import 'package:xinyue/page/message/message_page.dart';
import 'package:xinyue/page/person/person_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomTabPage(
      drawer: PersonPage(),
      pageList: (scaffoldContext) {
        return [MallPage(scaffoldContext: scaffoldContext), MessagePage()];
      },
      tabs: [
        BottomNavigationBarItem(
          icon: const Icon(Icons.home_outlined),
          activeIcon: const Icon(Icons.home),
          label: AppLocalizations.of(context).home,
        ),
        BottomNavigationBarItem(
          icon: const Icon(Icons.message_outlined),
          activeIcon: const Icon(Icons.message),
          label: AppLocalizations.of(context).messages,
        ),
      ],
    );
  }
}
